variable "resource_group_name" {
  type        = string
  description = "Name of the resource group to use"
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID to use"
}

variable "app_service_plan_name" {
  type        = string
  description = "Name of the app service plan to use"
}

variable "github_token" {
  type        = string
  description = "GitHub token to use"
}

variable "remote_repo_url" {
  type        = string
  description = "Remote repo URL to use"
  default     = "https://github.com/Jojo-GitH2/msdocs-python-django-webapp-quickstart"
}

variable "personal_resource_group_name" {
  type        = string
  description = "Name of the resource group to use"

}