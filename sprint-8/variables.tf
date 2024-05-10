variable "subscription_id" {
  description = "Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "service_plan_name" {
  description = "Service Plan Name"
  type        = string

}

variable "web_app" {
  description = "Web App"
  type = object({
    name = string
    site_config = object({
      ftps_state = string
      application_stack = object({
        python_version = string
      })
    })
  })
}

variable "remote_repo_url" {
  type = string
}

variable "virtual_network" {
  description = "virtual network and subnets"
  type = object({
    name          = string
    address_space = list(string)
    subnets = list(object({
      name           = string
      address_prefix = string
    }))
  })

}

variable "public_ip_name" {
  description = "Public IP Name"
  type        = string

}

variable "application_gateway" {
  description = "Application Gateway Name"
  type = object({
    name = string
    sku = object({
      name = string
      tier = string
    })
    frontend_port = object({
      port = number
    })
  })

}

variable "github_token" {
  description = "GitHub Token"
  type        = string

}

variable "zones" {
  description = "Zones"
  type        = list(string)

}
# variable "private_endpoints" {
#   description = "Private Endpoints"
#   type = list(object({
#     name = string
#     private_service_connection = object({
#       name = string
#     })

#   }))
# }