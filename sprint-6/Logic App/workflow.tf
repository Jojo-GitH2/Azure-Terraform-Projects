# Terraform Logic App Workflow
resource "azurerm_logic_app_workflow" "main" {
  name                = var.logic_app_workflow.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

}
