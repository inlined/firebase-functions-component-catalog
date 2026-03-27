provider "google" {
  project = "dummy-project"
  region  = "us-central1"
}

module "functions_v1_https" {
  source = "../../modules/functions_v1_https"

  name           = "my-function"
  project        = "my-project"
  region         = "us-central1"
  source_archive = "gs://my-bucket/my-object.tgz"
  invokers       = ["public"] # Or ["private"], or ["sa@", "user@example.com"]
}
