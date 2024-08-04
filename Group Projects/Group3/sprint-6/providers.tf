terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.76.0"
    }
    # null = {
    #   source  = "hashicorp/null"
    #   version = "3.2.1"
    # }
  }
}

provider "azurerm" {
  # Configuration options
  features {
  }
  subscription_id = var.subscription_id
}

# provider "null" {
#   # Configuration options
# }
