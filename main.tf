provider "google" {
  project = var.project_id
  region  = var.region 
}

resource "google_storage_bucket" "function_code_bucket" {
  name     = var.bucket_name
  location = var.region
}

# Upload the function code as an object in the bucket
resource "google_storage_bucket_object" "function_source" {
  name   = "gcloud-trading-bucket.zip"  # Name of the uploaded zip file
  bucket = google_storage_bucket.function_code_bucket.name
  source = var.source_zip_path 
}

# Create Cloud Function
resource "google_cloudfunctions_function" "my_function" {
  name        = "make_trade" # This is the name of the function in your main.py
  runtime     = "python310"  # Choose your preferred runtime
  entry_point = "make_trade"
  source_archive_bucket = google_storage_bucket.function_code_bucket.name
  source_archive_object = google_storage_bucket_object.function_source.name
  trigger_http = true
  available_memory_mb = 256
  region = var.region
  

  # This IAM role must have access to the bucket and permissions for your function
  service_account_email = var.service_account_email 
}

