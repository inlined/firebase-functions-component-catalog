locals {
  source_parts = regex("^gs://([^/]+)/(.+)$", var.source_zip)
  source_bucket = local.source_parts[0]
  source_object = local.source_parts[1]

  function_name = var.extension_id != null && var.extension_id != "" ? "ext-${var.extension_id}-${var.name}" : var.name

  service_account_email = var.service_account == null ? null : (can(regex("@$", var.service_account)) ? "${var.service_account}${var.project}.iam.gserviceaccount.com" : var.service_account)

  labels = merge(
    var.labels != null ? var.labels : {},
    {
      "goog-managed-by" = "firebase-functions"
    }
  )

  environment_variables = merge(
    var.environment_variables != null ? var.environment_variables : {},
    {
      "GCLOUD_PROJECT" = var.project
    },
    var.firebase_admin_config != null ? {
      "FIREBASE_CONFIG" = jsonencode(var.firebase_admin_config)
    } : {}
  )

  vpc_connector = {
    for r in var.regions : r => (
      var.vpc_connector != null && var.vpc_connector != "" ? (
        can(regex("/", var.vpc_connector)) ? var.vpc_connector : "projects/${var.project}/locations/${r}/connectors/${var.vpc_connector}"
      ) : null
    )
  }

  is_private = contains(var.invokers, "private")
  is_public  = contains(var.invokers, "public") || length(var.invokers) == 0

  invoker_members = local.is_private ? [] : (
    local.is_public ? ["allUsers"] : [
      for i in var.invokers : (
        can(regex("^allUsers$|^allAuthenticatedUsers$", i)) ? i : (
          can(regex("^[a-z]+:", i)) ? i : (
            can(regex("@$", i)) ? "serviceAccount:${i}${var.project}.iam.gserviceaccount.com" : "user:${i}"
          )
        )
      )
    ]
  )
}

resource "google_cloudfunctions_function" "this" {
  for_each = var.regions

  name                  = local.function_name
  project               = var.project
  region                = each.value
  description           = var.description
  runtime               = var.runtime
  available_memory_mb   = var.available_memory_mb
  timeout               = var.timeout
  entry_point           = var.name
  trigger_http          = true
  environment_variables = local.environment_variables
  labels                = local.labels
  vpc_connector         = local.vpc_connector[each.value]
  vpc_connector_egress_settings = var.vpc_connector_egress_settings
  max_instances         = var.max_instances
  min_instances         = var.min_instances
  ingress_settings      = var.ingress_settings
  service_account_email = local.service_account_email

  source_archive_bucket = local.source_bucket
  source_archive_object = local.source_object

  dynamic "secret_environment_variables" {
    for_each = var.secret_environment_variables
    content {
      key        = secret_environment_variables.value.key
      project_id = secret_environment_variables.value.project_id
      secret     = secret_environment_variables.value.secret
      version    = secret_environment_variables.value.version
    }
  }
}

resource "google_cloudfunctions_function_iam_binding" "invoker" {
  for_each = {
    for r in var.regions : r => google_cloudfunctions_function.this[r]
    if !local.is_private && length(local.invoker_members) > 0
  }

  project        = each.value.project
  region         = each.value.region
  cloud_function = each.value.name

  role    = "roles/cloudfunctions.invoker"
  members = local.invoker_members
}
