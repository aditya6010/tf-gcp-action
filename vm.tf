locals {
  capstone_service_account = {
    email  = var.sa_email
    scopes = ["cloud-platform"]
  }
}

data "template_file" "vm_startup_script" {
  template = file("./scripts/vmboot.sh")

}

resource "google_compute_address" "static-ip" {
  provider     = google
  name         = "static-ip"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
}

module "instance_template" {
  source          = "./modules/instance_template"
  depends_on      = [module.capstone-vpc, module.capstone-subnets]
  region          = var.region
  project_id      = var.project_id
  subnetwork      = module.capstone-subnets.subnets["${var.region}/subnet-01"].id
  service_account = local.capstone_service_account
  startup_script  = data.template_file.vm_startup_script.rendered
  access_config = [{
    nat_ip       = google_compute_address.static-ip.address
    network_tier = "PREMIUM"
  }]
  tags = ["ssh", "http"]
}

module "compute_instance" {
  source     = "./modules/compute_instance"
  depends_on = [module.capstone-vpc, module.capstone-subnets]
  region     = var.region
  #   subnetwork          = module.capstone-subnets.subnets["${var.region}/subnet-01"].id
  num_instances       = 1
  hostname            = "instance-simple"
  instance_template   = module.instance_template.self_link
  deletion_protection = false
}



# Create a single Compute Engine instance
# resource "google_compute_instance" "default" {
#   name         = "flask-vm"
#   depends_on = [ module.capstone-vpc, module.capstone-subnets ]
#   machine_type = "f1-micro"
#   zone = "us-east1-b"
#   tags         = ["ssh","http"]

#   service_account {
#      email = var.sa_email
#      scopes =["cloud-platform"]
#   }
#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#     }
#   }

#   # Install Flask
#   metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq nginx"

#   network_interface {
#     #  subnetwork = "subnet-01"
#     subnetwork = module.capstone-subnets.subnets["${var.region}/subnet-01"].id
#     network = module.capstone-vpc.network_name
#     access_config {
#      nat_ip = google_compute_address.static-ip.address
#     }
#   }
# }