resource "azurerm_virtual_network_peering" "peering1" {
  count                     = length(azurerm_virtual_network.spoke)
  name                      = "hub-to-${element(azurerm_virtual_network.spoke.*.name, count.index)}"
  resource_group_name       = data.azurerm_resource_group.main.name
  virtual_network_name      = azurerm_virtual_network.main.name
  remote_virtual_network_id = element(azurerm_virtual_network.spoke.*.id, count.index)

}

resource "azurerm_virtual_network_peering" "peering2" {
  count                     = length(azurerm_virtual_network.spoke)
  name                      = "${element(azurerm_virtual_network.spoke.*.name, count.index)}-to-hub"
  resource_group_name       = data.azurerm_resource_group.main.name
  virtual_network_name      = element(azurerm_virtual_network.spoke.*.name, count.index)
  remote_virtual_network_id = azurerm_virtual_network.main.id

}