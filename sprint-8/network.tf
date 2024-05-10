resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network.name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  address_space       = var.virtual_network.address_space

  subnet {
    name           = var.virtual_network.subnets[0].name
    address_prefix = var.virtual_network.subnets[0].address_prefix
  }
  subnet {
    name           = var.virtual_network.subnets[1].name
    address_prefix = var.virtual_network.subnets[1].address_prefix
  }
}