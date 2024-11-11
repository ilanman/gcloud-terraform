# variables.tf

variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
  default     = "trading-algo-bucket-1234" # setting the default project-id. Can remove this and enter each time.
}

variable "region" {
  description = "The region for the resources"
  type        = string
  default     = "us-east4"  # Default region
}