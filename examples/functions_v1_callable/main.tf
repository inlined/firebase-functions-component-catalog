provider "google" {
  project = "dummy-project"
  region  = "us-central1"
}

module "functions_v1_callable" {
  source = "../../modules/functions_v1_callable"

  name           = "my-function"
  project_id     = "my-project"
  region         = "us-central1"
  source_archive = "gs://my-bucket/my-object.tgz"
}
