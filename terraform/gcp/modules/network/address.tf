# GCP Public Compute Address
resource "google_compute_address" "vm_address" {
  name = "vm-ipv4-address"
}