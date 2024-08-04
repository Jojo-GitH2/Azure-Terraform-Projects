resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id                 = var.subnet_id
  network_security_group_id = var.network_security_group_id
}

resource "azurerm_network_interface" "this" {
  name                = "web-nic-1"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    primary = true
  }
  ip_configuration {
    name                          = "public"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.this.id

  }
}

resource "azurerm_public_ip" "this" {
  name = "web-pip-1"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method = "Dynamic"

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "web-vm-1"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]
  disable_password_authentication = false
  admin_password = var.admin_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

