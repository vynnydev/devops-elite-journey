
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
      "apt update",
      "Install Java for Jenkins...",
      "apt install openjdk-17-jdk -y",
      "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      "echo 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/' | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update",
      "Install Jenkins...",
      "sudo apt-get install jenkins",
      "Install Docker...",
      "curl -fsSL https://get.docker.com | sh",
      "Add Jenkins in Docker group",
      "usermod -aG docker jenkins",
      "systemctl restart jenkins",
      "Install Kubernetes Repository...",
      "sudo apt update",
      "sudo apt-get update",
      "sudo apt-get install -y ca-certificates curl",
      "sudo apt-get install -y apt-transport-https",
      "sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg",
      "echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main' | sudo tee /etc/apt/sources.list.d/kubernetes.list",
      "Install Kubectl...",
      "sudo apt-get update",
      "sudo apt-get install -y kubectl",
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