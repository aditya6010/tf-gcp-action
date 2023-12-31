# exit if any of the commands fails
set -o errexit

# format checking of terraform
terraform fmt -recursive

# validating configurations
terraform validate