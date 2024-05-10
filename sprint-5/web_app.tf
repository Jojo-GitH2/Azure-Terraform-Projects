# Production Web App
resource "azurerm_linux_web_app" "main" {
  location            = data.azurerm_service_plan.main.location
  name                = "app-python-jonah-prod-001"
  resource_group_name = data.azurerm_resource_group.personal.name
  service_plan_id     = data.azurerm_service_plan.main.id

  site_config {
    ftps_state = "AllAllowed"
    application_stack {
      python_version = "3.9"
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

# # Staging Web App
# resource "azurerm_linux_web_app_slot" "main" {
#   name           = "staging"
#   app_service_id = azurerm_linux_web_app.main.id

#   site_config {
#     ftps_state = "AllAllowed"
#     application_stack {
#       python_version = "3.9"
#     }
#     health_check_path = "/"

#   }
# }