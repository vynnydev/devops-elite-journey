
resource "google_compute_instance" "jenkins_vm" {
  depends_on = [
    var.fw_allow_all,
  ]

  name         = "${var.prefix}-jenkins-vm"
  machine_type = var.machine_type
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = data.google_compute_image.sles.self_link
    }
  }

  network_interface {
    network = var.vpc_application.name
    access_config {
      nat_ip = var.vm_address.address
    }
  }

  metadata = {
    ssh-keys       = "${local.node_username}:${tls_private_key.global_key.public_key_openssh}"
    enable-oslogin = "FALSE"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'SSH connection worked'",
    ]

    connection {
      type        = "ssh"
      host        = self.network_interface.0.access_config.0.nat_ip
      user        = local.node_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }
}