variable "subscription_id" {
  description = "Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "storage_account" {
  type = object({
    name                     = string
    account_tier             = string
    account_replication_type = string
    containers = list(object({
      name = string
      #   container_access_type = string
    }))
  })
  description = "storage account details"
}