# variables.tf

variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The region for the resources"
  type        = string
}

variable "service_account_email" {
  description = "Email of the service account for the Cloud Function"
  type        = string
}

variable "bucket_name" {
  description = "The name of the Cloud Storage bucket to store the function source code"
  type        = string
}

variable "source_zip_path" {
  description = "Local path to the Cloud Function source zip file"
  type        = string
}
