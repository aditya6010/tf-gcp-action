###########
#Include all the variables required by tf files here 
###########

variable "region" {
  description = "The region in which resources will be provisioned"
  type        = string
  default     = "us-east1"
}

variable "project_id" {
  description = "Project ID to be used to setup the resources"
  type        = string
}


variable "env" {
  description = "environment to setup the resources"
  type        = string
}



##################
# service_account
##################

# variable "service_account" {
#   type = object({
#     email  = string
#     scopes = set(string)
#   })
#   description = "Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template#service_account."
# }
variable "sa_email" {
  type = string
  description = "Email for service account"
}