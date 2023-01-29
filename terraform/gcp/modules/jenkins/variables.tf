variable "gcp_zone" {}
variable "vpc_application" {}
variable "fw_allow_all" {}
variable "machine_type" {}
variable "vm_address" {}
variable "prefix" {}

# Local variables used to reduce repetition
locals {
  node_username = "gcpuser"
}