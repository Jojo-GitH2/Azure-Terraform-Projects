data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account.name
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = var.storage_account.account_tier
  account_replication_type = var.storage_account.account_replication_type

}

resource "azurerm_service_plan" "main" {
  name                = var.service_plan.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  os_type             = var.service_plan.os_type
  sku_name            = var.service_plan.sku_name
}