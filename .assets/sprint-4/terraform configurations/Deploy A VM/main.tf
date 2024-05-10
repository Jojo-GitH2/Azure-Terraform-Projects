data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = "vnet-sprint4-${data.azurerm_resource_group.main.location}-001"
  address_space       = ["10.10.0.0/16"]
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  subnet {
    name           = "snet-sprint4-${data.azurerm_resource_group.main.location}-001"
    address_prefix = "10.10.1.0/24"
    security_group = azurerm_network_security_group.main.id
  }

  tags = {
    environment = "dev"
  }

}

# Network Security Group
resource "azurerm_network_security_group" "main" {
  name                = "nsg-weballow--001"
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
  }
}

# Network Interface 

resource "azurerm_network_interface" "main" {
  name                = "nic-01-vmtest-sprint4-001"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = "external"
    subnet_id                     = azurerm_virtual_network.main.subnet.*.id[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

# Public IP Address

resource "azurerm_public_ip" "main" {
  name                = "pip-vmtest-dev-${data.azurerm_resource_group.main.location}-001"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  allocation_method   = "Dynamic"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    environment = "dev"
  }
}

# Virtual Machine

resource "azurerm_linux_virtual_machine" "main" {
  name                = "vmtest-sprint4-dev-001"
  admin_username      = var.admin.username
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  size                = "Standard_B1s"
  

  network_interface_ids = [
    azurerm_network_interface.main.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    username   = var.admin.username
    public_key = file("C:\\Users\\Lawal\\.ssh\\id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-LTS"
    version   = "latest"
  }
}

resource "azurerm_managed_disk" "main" {
  name                 = "${azurerm_linux_virtual_machine.main.name}-data-disk"
  location             = data.azurerm_resource_group.main.location
  resource_group_name  = data.azurerm_resource_group.main.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "main" {
  managed_disk_id    = azurerm_managed_disk.main.id
  virtual_machine_id = azurerm_linux_virtual_machine.main.id
  lun                = 10
  caching            = "ReadWrite"
  create_option      = "Attach"
}