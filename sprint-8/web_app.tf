resource "azurerm_service_plan" "main" {
  name                = var.service_plan_name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "B1"
  # zone_balancing_enabled = true
}



resource "azurerm_linux_web_app" "main" {
  location            = azurerm_service_plan.main.location
  name                = var.web_app.name
  resource_group_name = data.azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    always_on  = "false"
    ftps_state = var.web_app.site_config.ftps_state
    application_stack {
      python_version = var.web_app.site_config.application_stack.python_version
    }
    health_check_path = "/"
  }

  logs {
    application_logs {
      file_system_level = "Information"
    }
  }

  #   auth_settings {
  #     enabled = true

  #   }

}