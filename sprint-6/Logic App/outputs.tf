output "storage_account" {
  value = [
    azurerm_storage_account.main.name,
    azurerm_storage_account.main.primary_access_key
  ]
  sensitive = true
}