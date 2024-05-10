resource "azurerm_storage_account" "main" {
  name                     = var.storage_account.name
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = var.storage_account.account_tier
  account_replication_type = var.storage_account.account_replication_type

}

resource "azurerm_storage_container" "main" {
  name                 = var.storage_account.container.name
  storage_account_name = azurerm_storage_account.main.name


}