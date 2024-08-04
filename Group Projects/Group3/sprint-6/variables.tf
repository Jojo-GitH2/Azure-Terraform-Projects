variable "subscription_id" {
  type        = string
  description = "value of the subscription id"

}

variable "resource_group_name" {
  type        = string
  description = "name of resource group"
}

variable "tags" {
  type        = map(string)
  description = "tags for the project"
}

variable "storage_account" {
  type = object({
    name                     = string
    account_tier             = string
    account_replication_type = string
    container_access_type    = string
    containers = list(object({
      name = string
    }))
  })
  description = "storage account details"

}

variable "service_plan" {
  type = object({
    name     = string
    os_type  = string
    sku_name = string
  })
  description = "service plan details"
}

variable "function_app" {
  type = object({
    name = string
    functions = list(object({
      name = string
    }))
  })
  description = "function app details"

}

variable "logic_app" {
  type = object({
    name = string
  })
  description = "logic app details"

}