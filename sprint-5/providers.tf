terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.76.0"
    }

    # github = {
    #   source  = "integrations/github"
    #   version = "5.40.0"
    # }
  }
}

provider "azurerm" {
  # Configuration options
  features {
  }
  subscription_id = var.subscription_id
}

# provider "github" {
#   token = var.github_token
# }