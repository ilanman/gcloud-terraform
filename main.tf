provider "google" {
  project = "woven-mapper-157313" # this is the project id for the trading algorithm 
  region  = "us-east4" 
}

resource "google_storage_bucket" "function_code_bucket" {
  name     = "trading-algo-bucket-1234"
  location = "US"
}

# Upload the function code as an object in the bucket
resource "google_storage_bucket_object" "function_source" {
  name   = "gcloud-trading-bucket.zip"  # Name of the uploaded zip file
  bucket = google_storage_bucket.function_code_bucket.name
  source = "/Users/ilan.man/gcloud-trading-bucket.zip"  # Local path to your zip file
}

# Create Cloud Function
resource "google_cloudfunctions_function" "my_function" {
  name        = "make_trade"
  runtime     = "python310"  # Choose your preferred runtime
  entry_point = "make_trade"
  source_archive_bucket = google_storage_bucket.function_code_bucket.name
  source_archive_object = "gcloud-trading-bucket.zip"
  trigger_http = true
  available_memory_mb = 256
  region = "us-east4"

  # This IAM role must have access to the bucket and permissions for your function
  service_account_email = "woven-mapper-157313@appspot.gserviceaccount.com"  # Replace with your Cloud Function service account email
}

