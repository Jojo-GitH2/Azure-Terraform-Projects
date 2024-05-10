terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.77.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = var.subscription_id
}

provider "local" {
  # Configuration options
}