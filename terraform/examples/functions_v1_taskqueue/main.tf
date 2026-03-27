provider "google" {
  project = "dummy-project"
  region  = "us-central1"
}

module "functions_v1_taskqueue" {
  source = "../../modules/functions_v1_taskqueue"

  name           = "my-task-function"
  project_id     = "my-project"
  region         = "us-central1"
  source_archive = "gs://my-bucket/my-object.tgz"
  invokers       = ["public"] # Or ["private"], or ["sa@", "user@example.com"]

  rate_limits_max_concurrent_dispatches = 10
  rate_limits_max_dispatches_per_second = 5
  retry_config_max_attempts             = 3
}
