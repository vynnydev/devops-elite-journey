########### COMMOM ###########
variable "gcp_project" {
  default = "code-microservices"
}

variable "gcp_region" {
  default = "us-central1"
}

variable "gcp_zone" {
  default = "us-central1-b"
}

variable "machine_type" {
  type        = string
  description = "Machine type used for all compute instances"
  default     = "f1-micro"
}

variable "prefix" {
  type        = string
  description = "Prefix added to names of all resources"
  default     = "tfk8s"
}