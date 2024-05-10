variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string

}

variable "virtual_network" {
  description = "Azure virtual network"
  type = object({
    name          = string
    address_space = list(string)
    location      = string
    subnets       = map(string)
  })
}

variable "tags" {
  description = "tags to be applied to all resources"
  type        = map(string)

}