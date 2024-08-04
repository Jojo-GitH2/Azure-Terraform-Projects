
resource "azurerm_subnet_network_security_group_association" "db" {
  subnet_id                 = var.subnet_id
  network_security_group_id = var.network_security_group_id
}

resource "azurerm_network_interface" "this" {
  name                = "db-nic-1"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "db-vm-1"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]
  disable_password_authentication = false
  admin_password                  = var.admin_password

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


# resource "azurerm_mssql_virtual_machine" "example" {
#   virtual_machine_id               = azurerm_linux_virtual_machine.main.id
#   sql_license_type                 = "PAYG"
#   r_services_enabled               = true
#   sql_connectivity_port            = 1433
#   sql_connectivity_type            = "PRIVATE"
#   sql_connectivity_update_password = var.admin_password
#   sql_connectivity_update_username = var.admin_username

# }