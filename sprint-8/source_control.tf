# # Main branch Source Control
# resource "azurerm_app_service_source_control" "main" {
#   branch   = "main"
#   app_id   = azurerm_linux_web_app.main.id
#   repo_url = var.remote_repo_url

#   github_action_configuration {
#     code_configuration {
#       runtime_stack   = "python"
#       runtime_version = "3.9"
#     }
#     generate_workflow_file = true
#   }
# }

# resource "azurerm_source_control_token" "main" {
#   type  = "GitHub"
#   token = var.github_token

# }