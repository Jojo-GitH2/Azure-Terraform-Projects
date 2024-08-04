resource "azurerm_logic_app_workflow" "main" {
  name                = var.logic_app.name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

}