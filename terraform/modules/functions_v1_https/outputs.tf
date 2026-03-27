output "name" {
  description = "The computed name of the function."
  value       = google_cloudfunctions_function.this.name
}

output "id" {
  description = "The ID of the function."
  value       = google_cloudfunctions_function.this.id
}

output "url" {
  description = "The URL of the HTTPS trigger."
  value       = google_cloudfunctions_function.this.https_trigger_url
}