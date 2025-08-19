variable "resource_group_name" {}
variable "location" {
  default = "eastus"
}

variable "cluster_name" {}
variable "dns_prefix" {}
variable "node_count" {
  default = 1
}

# Free-tier eligible VM
variable "vm_size" {
  default = "Standard_B2s"
}
variable "environment" {}