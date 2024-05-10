variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}
variable "subscription_id" {
  description = "Subscription ID"
  type        = string
}

variable "subnet_prefixes" {
  description = "Subnet prefixes"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}


  