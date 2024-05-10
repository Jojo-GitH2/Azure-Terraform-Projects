resource "azurerm_linux_function_app" "main" {
  location            = data.azurerm_resource_group.main.location
  name                = var.function_app.name
  resource_group_name = data.azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.main.id

  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key

  site_config {
    application_stack {
      python_version = "3.9"
    }
  }
}

