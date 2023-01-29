terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.24.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.4.0"
    }
  }

  /*
  backend "gcs" {
   bucket  = "4218a56b2bd832c8-bucket-tfstate"
   prefix  = "tfk8s/state"
  } */

  required_version = ">= 1.0.0"
}

provider "google" {
  credentials = file("instance.json")
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
}
