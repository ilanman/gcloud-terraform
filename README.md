# GCP Trading Algorithm Infrastructure with Terraform

This project sets up the infrastructure required to deploy a Google Cloud Function for a trading algorithm using Google Cloud Platform (GCP) resources. The setup includes a Google Cloud Storage bucket to store the function source code and a Cloud Function that triggers HTTP requests to run the trading algorithm.

## Project Structure

```
.
├── .terraform                   # Terraform directory for state management
├── .terraform.lock.hcl          # Terraform lock file for dependencies
├── main.tf                      # Main configuration for GCP resources
├── outputs.tf                   # Output definitions for Terraform
├── terraform.tfstate            # Terraform state file (generated)
├── terraform.tfstate.backup     # Terraform state backup file
├── variables.tf                 # Variable definitions for project configuration
└── README.md                    # Project documentation
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) installed locally
- A Google Cloud account and project with billing enabled
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed locally
- Google Cloud Function service account with appropriate permissions (Cloud Functions Invoker, Storage Object Viewer)

## Setup Instructions

### 1. Authenticate with Google Cloud

Ensure you are authenticated with Google Cloud:

```bash
gcloud auth login
gcloud auth application-default login
```

### 2. Initialize Terraform

Initialize the project to download the required provider plugins:

```bash
terraform init
```

### 3. Configure Variables

This project includes variables with default values defined in `variables.tf`. You can adjust these as needed, or you can override them in a `terraform.tfvars` file or through the command line.

- `project_id`: Your Google Cloud project ID (default: `"trading-algo-bucket-1234"`)
- `region`: The GCP region to deploy resources (default: `"us-east4"`)

### 4. Deploy the Infrastructure

To apply the Terraform configuration and deploy resources, run:

```bash
terraform apply
```

Enter `yes` when prompted to confirm the changes.

### 5. Check Outputs

After deployment, Terraform will output the following:

- `bucket_name`: The name of the Cloud Storage bucket where the function source code is stored.
- `function_url`: The HTTP endpoint to trigger the deployed Cloud Function.

You can access the Cloud Function URL to test its deployment.

## Resources Created

This Terraform configuration creates the following resources:

- **Google Cloud Storage Bucket**: Stores the function code as a zip file.
- **Google Cloud Storage Bucket Object**: The zip file containing the Cloud Function source code.
- **Google Cloud Function**: A function deployed to run the trading algorithm, triggered by HTTP requests.

### `main.tf`

The main configuration file that defines all resources. Key sections:

1. **Provider Configuration**: Sets up the Google provider with project and region.
2. **Storage Bucket**: Creates a bucket to store the function source code.
3. **Storage Bucket Object**: Uploads the function source zip file to the bucket.
4. **Cloud Function**: Deploys a Cloud Function named `make_trade`.

### `variables.tf`

Contains variable definitions for the project, including:
- `project_id`: The GCP project ID where resources are created.
- `region`: The region in which resources are deployed.

## Permissions and IAM

The Cloud Function requires permissions to read from the Storage bucket. Ensure the service account used (`woven-mapper-157313@appspot.gserviceaccount.com`) has the following roles:
- **Storage Object Viewer** for the bucket containing the function source code.
- **Cloud Functions Invoker** for public access (if unauthenticated access is required).

To grant public access, run:

```bash
gcloud functions add-iam-policy-binding make_trade \
  --region us-east4 \
  --member="allUsers" \
  --role="roles/cloudfunctions.invoker"
```

## Troubleshooting

- **403 Forbidden**: Ensure the function has the `Cloud Functions Invoker` role for `allUsers` if it should be publicly accessible.
- **500 Internal Server Error**: Check Cloud Function logs for stack traces or errors:
  ```bash
  gcloud functions logs read make_trade --region us-east4
  ```

## Clean Up

To remove all resources created by this Terraform configuration, run:

```bash
terraform destroy
```

Confirm with `yes` to delete all resources.

## How to use this repo for initializing a new Terraform project on GCP

### Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/gcloud-trading-terraform.git
   cd gcloud-trading-terraform
   ```

2. **Configure User-Specific Variables**:
   - Copy `terraform.tfvars.example` to `terraform.tfvars`:
     ```bash
     cp terraform.tfvars.example terraform.tfvars
     ```
   - Open `terraform.tfvars` and update the values for:
     - `project_id`: Your Google Cloud project ID
     - `service_account_email`: The service account email for your Cloud Function
     - `bucket_name`: The name of the storage bucket for your function code
     - `source_zip_path`: Path to the source zip file on your local machine

3. **Initialize and Apply Terraform**:
   - Run `terraform init` to initialize the project and download provider plugins.
   - Deploy the infrastructure with `terraform apply` and confirm with `yes`.

4. Add `.gitignore` to Exclude `terraform.tfvars`

Since `terraform.tfvars` will contain user-specific and possibly sensitive information, add it to `.gitignore` to prevent it from being accidentally committed:

```plaintext
# Ignore user-specific variable files
terraform.tfvars
```

5. Push Changes to GitHub

After making these changes, commit and push them to GitHub:

```bash
git add .
git commit -m "Add user-specific variables setup"
git push origin main
```

### Final Workflow for Users

After cloning the repository, a new user would:

1. Copy `terraform.tfvars.example` to `terraform.tfvars`.
2. Edit `terraform.tfvars` to set up their own project-specific configurations.
3. Run `terraform init` and `terraform apply` to deploy resources.

## License

This project is licensed under the MIT License.
```
