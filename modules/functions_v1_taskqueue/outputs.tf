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

output "queue_name" {
  description = "The name of the Task Queue."
  value       = google_cloud_tasks_queue.this.name
}

output "queue_id" {
  description = "The ID of the Task Queue."
  value       = google_cloud_tasks_queue.this.id
}