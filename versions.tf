###################################
# This is to fix the version for the required providers and terraform execution environment
# e.g. google version 4.74.0
# terraform version as 1.5.3
###################################
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.47.0"
    }
  }
  required_version = "<= 1.5.2"
}
