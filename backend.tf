terraform {
  backend "gcs" {
    bucket  = "ce-tf-capstone-state"
    prefix  = "terraform/state"
  }
}


data "terraform_remote_state" "capstone-state" {
  backend = "gcs"
  workspace = "${terraform.workspace}"
  config = {
    bucket  = "ce-tf-capstone-state"
    prefix  = "terraform/state"
  }
}