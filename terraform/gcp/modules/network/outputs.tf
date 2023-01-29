output "vpc_application" {
  value = google_compute_network.vpc_network
}

output "private_subnet" {
  value = google_compute_subnetwork.private
}

output "fw_allow_all" {
  value = google_compute_firewall.fw_allow_all
}

output "fw_allow_ssh" {
  value = google_compute_firewall.fw_allow_ssh
}

output "vm_address" {
  value = google_compute_address.vm_address
}