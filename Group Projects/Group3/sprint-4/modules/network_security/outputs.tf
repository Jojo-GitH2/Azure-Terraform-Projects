output "subnet_ids" {
  value = azurerm_subnet.this[*].id

}

output "security_group_ids" {
  value = [azurerm_network_security_group.web.id, azurerm_network_security_group.app.id, azurerm_network_security_group.db.id]
}