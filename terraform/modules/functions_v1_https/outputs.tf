output "name" {
  description = "The computed name of the function."
  value       = local.function_name
}

output "functions" {
  description = "A map of region to function details."
  value = {
    for r in var.regions : r => {
      name              = google_cloudfunctions_function.this[r].name
      id                = google_cloudfunctions_function.this[r].id
      https_trigger_url = google_cloudfunctions_function.this[r].https_trigger_url
    }
  }
}
