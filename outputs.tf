# outputs.tf

output "bucket_name" {
  description = "The name of the storage bucket"
  value       = google_storage_bucket.function_code_bucket.name
}

output "function_url" {
  description = "The HTTP URL of the deployed Cloud Function"
  value       = google_cloudfunctions_function.my_function.https_trigger_url
}