variable "resource_group_name" {
  type        = string
  description = "name of resource group"
}

variable "subscription_id" {
  type        = string
  description = "subscription id"

}

variable "storage_account" {
  type        = map(string)
  description = "storage account details"
}

variable "service_plan" {
  type        = map(string)
  description = "service plan details"
}

variable "function_app" {
  type        = map(string)
  description = "function app details"

}

variable "function" {
  type        = map(string)
  description = "function app function details"

}