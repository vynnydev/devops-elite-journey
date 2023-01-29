# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall
resource "google_compute_firewall" "fw_allow_ssh" {
  name    = "fw-allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "fw_allow_all" {
  name    = "${var.prefix}-allowall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
}