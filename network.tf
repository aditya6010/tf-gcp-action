# resource "google_compute_network" "vpc_network" {
#   name = "terraform-network"
# }


module "capstone-vpc" {
  source                  = "./modules/vpc"
  name                    = "terraform-VPC"
  auto_create_subnetworks = false
  project_id              = var.project_id
  environment             = var.env
}

module "capstone-subnets" {
  source       = "./modules/subnets"
  project_id   = var.project_id
  network_name = module.capstone-vpc.network_name
  subnets = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = var.region
      subnet_private_access = "true"
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = var.region
      subnet_private_access = "true"
    }
  ]
}

# module "route" {
#   source = "./modules/routes"
#   project_id = var.project_id
#   depends_on = [ module.capstone-vpc, module.capstone-subnets ]
#   network_name = module.capstone-vpc.network_name
#   routes = [
#     {
#       name              = "egress-internet"
#       description       = "route through IGW to access internet"
#       destination_range = "0.0.0.0/0"
#       tags              = "egress-inet"
#       next_hop_internet = "true"
#     }
#   ] 
# }


resource "google_compute_firewall" "ssh" {
  name       = "allow-ssh"
  depends_on = [module.capstone-vpc, module.capstone-subnets]
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = module.capstone-vpc.network_id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}

resource "google_compute_firewall" "http" {
  name       = "allow-http"
  depends_on = [module.capstone-vpc, module.capstone-subnets]
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = module.capstone-vpc.network_id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http"]
}



