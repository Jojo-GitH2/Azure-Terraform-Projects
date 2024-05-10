# create a virtual network with 3 subnets
resource "azurerm_virtual_network" "main" {
  name                = "VNet-sprint-3"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "dev"
  }
}

# create a subnet for each prefix in the list

resource "azurerm_subnet" "main" {
  count                = length(var.subnet_prefixes)
  name                 = "subnet-${count.index + 1}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.subnet_prefixes[count.index]]
}

