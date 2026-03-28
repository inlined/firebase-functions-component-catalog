output "config" {
  description = "The Firebase admin config object."
  value = {
    projectId     = var.projectId
    databaseURL   = var.databaseURL
    storageBucket = var.storageBucket
    location      = var.location
  }
}
