variable "resource_group_name" {
  type        = string
  description = "name of resource group"
}

variable "subscription_id" {
  type        = string
  description = "subscription id"

}

variable "logic_app_workflow" {
  type = object({
    name = string
  })
  description = "logic app workflow"

}

variable "storage_account" {
  type = object({
    name                     = string
    account_tier             = string
    account_replication_type = string
    container = object({
      name                  = string
      container_access_type = string
    })
  })
  description = "storage account details"
}

