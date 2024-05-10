# Fetch resource group data
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}



