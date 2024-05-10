variable "subscription_id" {
  description = "value of the Azure subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string

}

variable "tags" {
  description = "tags to be applied to all resources"
  type        = map(string)
}

variable "virtual_networks" {
  description = "Azure virtual networks"
  type = map(object({
    # name          = string
    address_space = list(string)
    location      = string
    subnets       = map(string)
    })
  )
}