variable "location" {
  description = "The Azure Region in which all resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tiers" {
  description = "list of tiers to create"
  type        = list(string)
  # Indexing in a List starts from 0
  default     = ["web", "app", "db"]

}
