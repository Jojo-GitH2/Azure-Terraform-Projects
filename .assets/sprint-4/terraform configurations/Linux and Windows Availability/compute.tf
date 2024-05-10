# Network Interface 

resource "azurerm_network_interface" "linux" {
  name                = "nic-01-vmtest-sprint4-003"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = "external"
    subnet_id                     = azurerm_virtual_network.main.subnet.*.id[0]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux.id
  }
}

# Network Interface 

resource "azurerm_network_interface" "windows" {
  name                = "nic-01-vmtest-sprint4-004"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                          = "external"
    subnet_id                     = azurerm_virtual_network.main.subnet.*.id[1]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows.id
  }
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "main" {
  name                         = "vmtest-sprint4-dev-003"
  admin_username               = var.admin.username
  location                     = data.azurerm_resource_group.main.location
  resource_group_name          = data.azurerm_resource_group.main.name
  size                         = "Standard_B1s"
  user_data                    = base64encode(file("${path.module}/scripts/install_apache.sh"))
  # availability_set_id          = azurerm_availability_set.main.id
  virtual_machine_scale_set_id = azurerm_orchestrated_virtual_machine_scale_set.main.id
  network_interface_ids = [
    azurerm_network_interface.linux.id
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


# Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "main" {
  name                         = "vmtest-sprint4-dev-004"
  admin_username               = var.admin.username
  admin_password               = var.admin.password
  location                     = data.azurerm_resource_group.main.location
  resource_group_name          = data.azurerm_resource_group.main.name
  size                         = "Standard_B1s"
  computer_name                = "Jonah"
  # availability_set_id          = azurerm_availability_set.main.id
  virtual_machine_scale_set_id = azurerm_orchestrated_virtual_machine_scale_set.main.id

  network_interface_ids = [
    azurerm_network_interface.windows.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# Windows Custom Script Extension
resource "azurerm_virtual_machine_extension" "windows" {
  name                 = "${azurerm_windows_virtual_machine.main.name}-customscript"
  virtual_machine_id   = azurerm_windows_virtual_machine.main.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
  {
    "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeManagementTools; exit 0"
  }
  SETTINGS
}
