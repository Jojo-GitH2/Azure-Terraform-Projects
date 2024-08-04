# Create Network Security Groups
resource "azurerm_network_security_group" "web" {
  name                = "${var.tiers[0]}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

   security_rule {
    name                       = "allow-ssh"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allow-HTTPS"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-Web-to-App"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = azurerm_subnet.this[0].address_prefixes[0]
    destination_address_prefix = azurerm_subnet.this[1].address_prefixes[0]
  }

}

resource "azurerm_network_security_group" "app" {
  name                = "${var.tiers[1]}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-Web-to-App"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = azurerm_subnet.this[0].address_prefixes[0]
    destination_address_prefix = azurerm_subnet.this[1].address_prefixes[0]
  }

  security_rule {
    name                       = "Allow-App-to-DB"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433" # Port for SQL Server
    source_address_prefix      = azurerm_subnet.this[1].address_prefixes[0]
    destination_address_prefix = azurerm_subnet.this[2].address_prefixes[0]
  }

}

resource "azurerm_network_security_group" "db" {
  name                = "${var.tiers[2]}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-App-to-DB"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433" # Port for SQL Server
    source_address_prefix      = azurerm_subnet.this[1].address_prefixes[0]
    destination_address_prefix = azurerm_subnet.this[2].address_prefixes[0]
  }

}

