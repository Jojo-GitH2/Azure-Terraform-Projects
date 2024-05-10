output "resource_group_id" {
  value = data.azurerm_resource_group.main.id
}

output "spokes" {
  value = azurerm_virtual_network.spoke
}