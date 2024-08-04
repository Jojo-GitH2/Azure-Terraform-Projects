data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_service_plan" "main" {
  name                = var.app_service_plan_name
  resource_group_name = data.azurerm_resource_group.main.name
} 

data "azurerm_resource_group" "personal" {
  name = var.personal_resource_group_name
}