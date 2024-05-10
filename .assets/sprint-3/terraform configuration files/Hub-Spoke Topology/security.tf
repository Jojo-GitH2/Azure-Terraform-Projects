resource "azurerm_network_security_group" "hub" {
  name                = "hub-${data.azurerm_resource_group.main.location}-nsg"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  security_rule {

    name                       = "deny-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"


  }
  security_rule {
    name                       = "allow-rdp"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }

  security_rule {
    name                       = "allow-ssh"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  tags = {
    NetworkType = "Hub"
  }
}

resource "azurerm_network_security_group" "spoke" {
  count               = length(var.spoke_locations)
  name                = "spoke-${var.spoke_locations[count.index]}-nsg"
  location            = var.spoke_locations[count.index]
  resource_group_name = data.azurerm_resource_group.main.name

  security_rule {
    name                       = "allow-rdp"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }
  security_rule {
    name                       = "deny-http"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }

  security_rule {
    name                       = "allow-ssh"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = tolist(azurerm_virtual_network.main.subnet)[0].address_prefix
    destination_address_prefix = "*"
  }

  tags = {
    NetworkType = "Spoke"
  }

}

resource "azurerm_subnet_network_security_group_association" "hub" {
  #   subnet_id                 = azurerm_virtual_network.main.subnet[0].id
  subnet_id                 = tolist(azurerm_virtual_network.main.subnet)[0].id
  network_security_group_id = azurerm_network_security_group.hub.id
}

resource "azurerm_subnet_network_security_group_association" "spoke" {
  count = length(var.spoke_locations)
  # subnet_id                 = tolist(azurerm_virtual_network.spoke)[count.index].subnet[0].id
  subnet_id                 = tolist(azurerm_virtual_network.spoke[count.index].subnet)[0].id
  network_security_group_id = azurerm_network_security_group.spoke[count.index].id
}

