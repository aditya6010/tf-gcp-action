###############################################
# Include all terraform resource providers here
###############################################


###############################################
# Setup Google provider here (this is to get authenticate GCP and get basic configuration)
# Reference: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication
###############################################

provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = "us-east1-a"
  credentials = "C:/HashiCorp/ce-tf-capstone-654c4da04894.json"
}
