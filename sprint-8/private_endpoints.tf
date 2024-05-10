# resource "azurerm_private_endpoint" "app_service" {
#   name = var.private_endpoints.name
#   resource_group_name = data.azurerm_resource_group.main.name
#   location = data.azurerm_resource_group.main.location
#   subnet_id = azurerm_virtual_network.main.subnet.*.id[1]

#   private_service_connection {
#     name = var.private_endpoints.private_service_connection.name
#     is_manual_connection = false
#     private_connection_resource_id = azurerm_linux_web_app.main.id

#   }
# }