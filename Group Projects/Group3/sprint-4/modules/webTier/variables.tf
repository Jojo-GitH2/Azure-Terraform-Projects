variable "location" {
  description = "The Azure Region in which all resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "value of the subnet id"
  type        = string
}

variable "network_security_group_id" {
  description = "value of the network security group id"
  type        = string
}

# variable "admin_password" {
#   description = "value of the admin password"
#   type        = string
# }
variable "admin_username" {
  description = "value of the admin username"
  type        = string
}

# variable "admin_ssh_public_key" {
#   description = "value of the admin ssh public key"
#   type        = string
# }

