module "network" {
  source = "./modules/network"

  prefix = var.prefix
  gcp_region = var.gcp_region
}

module "gke" {
  source = "./modules/gke"

  vpc_application = module.network.vpc_application
  private_subnet = module.network.private_subnet
}

module "jenkins" {
  source = "./modules/jenkins" 

  gcp_zone = var.gcp_zone
  vpc_application = module.network.vpc_application
  fw_allow_all = module.network.fw_allow_all
  machine_type = var.machine_type
  vm_address = module.network.vm_address
  prefix = var.prefix
}