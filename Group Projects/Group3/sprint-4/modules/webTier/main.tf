resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id                 = var.subnet_id
  network_security_group_id = var.network_security_group_id
}

# resource "azurerm_network_interface" "this" {
#   name                = "web-nic-1"
#   location            = var.location
#   resource_group_name = var.resource_group_name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = var.subnet_id
#     private_ip_address_allocation = "Dynamic"
#     primary                       = true
#   }
#   ip_configuration {
#     name                          = "public"
#     subnet_id                     = var.subnet_id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.this.id

#   }
# }

# resource "azurerm_public_ip" "this" {
#   name                = "pip-linuxvm-dev-${var.location}-001}"
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   allocation_method   = "Static"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "azurerm_linux_virtual_machine" "main" {
#   name                = "web-vm-1"
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   size                = "Standard_B1s"
#   admin_username      = var.admin_username
#   network_interface_ids = [
#     azurerm_network_interface.this.id,
#   ]
#   disable_password_authentication = false
#   admin_password                  = var.admin_password

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-focal"
#     sku       = "20_04-lts"
#     version   = "latest"
#   }
# }

resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                = "vmms-web-dev-001"
  location            = var.location
  resource_group_name = var.resource_group_name
  admin_username      = var.admin_username
  instances           = 2
  sku                 = "Standard_B1s"
  upgrade_mode        = "Automatic"
  zones               = ["2", "3"]
  zone_balance        = true
  user_data           = base64encode(file("${path.module}/scripts/install_apache.sh"))

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  network_interface {
    name                      = "nic-01-web-sprin4-001"
    network_security_group_id = var.network_security_group_id
    primary                   = true

    ip_configuration {
      name                                   = "internal"
      subnet_id                              = var.subnet_id
      primary                                = true
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.main.id]
    }

    # ip_configuration {
    #   name      = "public"
    #   subnet_id = var.subnet_id
    # public_ip_address {
    #   name                = "pip-01-linuxvm-sprin4-001"
    #   # public_ip_prefix_id = azurerm_public_ip.this.id

    # }


    # }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_ZRS"
  }

  data_disk {
    caching              = "ReadWrite"
    create_option        = "Empty"
    disk_size_gb         = 30
    lun                  = 1
    storage_account_type = "StandardSSD_ZRS"

  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("C:\\Users\\Lawal\\.ssh\\id_rsa.pub")
  }
}
