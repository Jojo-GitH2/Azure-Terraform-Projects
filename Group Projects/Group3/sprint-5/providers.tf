terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.76.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
  }
  subscription_id = var.subscription_id
}
