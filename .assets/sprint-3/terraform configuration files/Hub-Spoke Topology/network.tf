# Hub Network
# create a virtual network for the hub
resource "azurerm_virtual_network" "main" {
  name                = "hub-vnet-${data.azurerm_resource_group.main.location}"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  address_space       = ["10.1.0.0/16"]

  subnet {
    name           = "subnet-hub"
    address_prefix = "10.1.1.0/24"
  }

  tags = {
    NetworkType = "Hub"
  }
}

# Spoke Virtual Networks
# create a virtual network for each spoke
resource "azurerm_virtual_network" "spoke" {
  count               = length(var.spoke_locations)
  name                = "spoke-vnet-${var.spoke_locations[count.index]}"
  location            = var.spoke_locations[count.index]
  resource_group_name = data.azurerm_resource_group.main.name
  address_space       = ["10.${count.index + 2}.0.0/16"]

  subnet {
    name           = "subnet-spoke-${var.spoke_locations[count.index]}"
    address_prefix = "10.${count.index + 2}.1.0/24"
  }

  tags = {
    NetworkType = "Spoke"
  }
}

# resource "azurerm_subnet" "main" {
#   name = "subnet-hub"
#   resource_group_name = data.azurerm_resource_group.main.name
#   virtual_network_name = azurerm_virtual_network.main.name
#   address_prefixes = [

# }

# create a subnet for each prefix in the list

# resource "azurerm_subnet" "main" {
#   count                = length(var.subnet_prefixes)
#   name                 = "subnet-${count.index + 1}"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.main.name
#   address_prefixes     = [var.subnet_prefixes[count.index]]
# }

