resource "azurerm_virtual_network" "this" {
  name                = var.virtual_network.name
  resource_group_name = var.resource_group_name
  address_space       = var.virtual_network.address_space
  location            = var.virtual_network.location
}

resource "azurerm_subnet" "this" {
  for_each             = var.virtual_network.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value]
}