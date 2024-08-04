resource "azurerm_storage_account" "main" {
  name                     = var.storage_account.name
  resource_group_name      = data.azurerm_resource_group.main.name
  account_tier             = var.storage_account.account_tier
  account_replication_type = var.storage_account.account_replication_type
  location                 = data.azurerm_resource_group.main.location

  tags = var.tags

}

resource "azurerm_storage_container" "function" {
  name                  = var.storage_account.containers[0].name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = var.storage_account.container_access_type

}

resource "azurerm_storage_container" "logic" {
  name                  = var.storage_account.containers[1].name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = var.storage_account.container_access_type

}



# resource "null_resource" "storage_account_access_key" {
#   triggers = {
#     storage_account_id = azurerm_storage_account.main.id
#   }

#   provisioner "local-exec" {
#     command = "az storage account keys list --account-name ${azurerm_storage_account.main.name} --resource-group ${data.azurerm_resource_group.main.name} --query [0].value -o tsv > storage_account_key.txt"
#   }

# }

