# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "vnet-sprint4-${data.azurerm_resource_group.main.location}-003"
  address_space       = ["10.10.0.0/16"]
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  subnet {
    name           = "snet-sprint4-${data.azurerm_resource_group.main.location}-003"
    address_prefix = "10.10.1.0/24"
    security_group = azurerm_network_security_group.linux.id
  }

  subnet {
    name           = "snet-sprint4-${data.azurerm_resource_group.main.location}-004"
    address_prefix = "10.10.2.0/24"
    security_group = azurerm_network_security_group.windows.id
  }

  tags = {
    environment = "dev"
    sprint      = "4"
  }

}

# Network Security Group
resource "azurerm_network_security_group" "linux" {
  name                = "nsg-weballow-002"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  security_rule {
    name                       = "allow-http"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

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
    name                       = "allow-https"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "dev"
    sprint      = "4"
  }
}

# Public IP Address
resource "azurerm_public_ip" "linux" {
  name                = "pip-sprint4-${data.azurerm_resource_group.main.location}-003"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    environment = "dev"
    sprint      = "4"
  }
}

resource "azurerm_network_security_group" "windows" {
  name                = "nsg-weballow-003"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  security_rule {
    name                       = "allow-http"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

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
    name                       = "allow-https"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-rdp"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "dev"
    sprint      = "4"
  }
}


# Public IP Address
resource "azurerm_public_ip" "windows" {
  name                = "pip-sprint4-${data.azurerm_resource_group.main.location}-004"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    environment = "dev"
    sprint      = "4"
  }
}
