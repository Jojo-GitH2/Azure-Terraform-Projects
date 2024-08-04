resource "azurerm_service_plan" "main" {
  name                = var.service_plan.name
  location            = data.azurerm_resource_group.main.location
  os_type             = var.service_plan.os_type
  resource_group_name = data.azurerm_resource_group.main.name
  sku_name            = var.service_plan.sku_name

  tags = var.tags
}

resource "azurerm_linux_function_app" "main" {
  name                = var.function_app.name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.main.id

  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key

  site_config {
    application_stack {
      python_version = "3.9"
    }

    cors {
      allowed_origins     = ["https://portal.azure.com"]
      support_credentials = false
    }
  }

  app_settings = {
    "AzureWebJobsFeatureFlags" = "EnableWorkerIndexing"
  }

  tags = var.tags
}

# resource "azurerm_function_app_function" "main" {
#   name            = var.function_app.functions[0].name
#   function_app_id = azurerm_linux_function_app.main.id
#   language        = "Python"

#   file {
#     name    = "function_app.py"
#     content = file("${path.module}/function/function_app.py")
#   }

#   config_json = jsonencode({
#     "bindings" = [
#       {
#         "authLevel" = "function"
#         "direction" = "in"
#         "methods" = [
#           "get",
#           "post"
#         ]
#         "name" = "req"
#         "type" = "httpTrigger"
#       },
#       {
#         "direction" = "out"
#         "name"      = "$return"
#         "type"      = "http"
#       }
#     ]
#   })
# }