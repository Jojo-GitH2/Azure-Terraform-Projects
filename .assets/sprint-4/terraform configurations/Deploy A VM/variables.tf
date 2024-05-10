variable "subscription_id" {
  type        = string
  description = "value of the subscription ID"
}

variable "resource_group_name" {
  type        = string
  description = "value of the resource group name"


}

variable "admin" {
  type = object({
    username = string
    password = string
  })
}
