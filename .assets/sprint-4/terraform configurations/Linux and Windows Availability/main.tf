# Resource Group
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}




# # Public IP Address

# resource "azurerm_public_ip" "main" {
#   name                = "pip-vmtest-dev-${data.azurerm_resource_group.main.location}-001"
#   location            = data.azurerm_resource_group.main.location
#   resource_group_name = data.azurerm_resource_group.main.name
#   allocation_method   = "Dynamic"

#   lifecycle {
#     create_before_destroy = true
#   }

#   tags = {
#     environment = "dev"
#   }
# }

# Virtual Machine


# # Load balancer
# resource "azurerm_lb" "main" {
#   name                = "lb-vmss-sprint4-dev-001"
#   location            = data.azurerm_resource_group.main.location
#   resource_group_name = data.azurerm_resource_group.main.name
#   sku                 = "Standard"
#   depends_on          = [azurerm_virtual_network.main]

#   frontend_ip_configuration {
#     name                 = "PublicIPAddress"
#     public_ip_address_id = azurerm_public_ip.main.id
#     # zones                = [var.zones[0], var.zones[1]]
#     # subnet_id            = azurerm_virtual_network.main.subnet.*.id[0]

#   }
# }

# # Load balancer backend pool
# resource "azurerm_lb_backend_address_pool" "main" {
#   name               = "lb-backend-pool-vmss-sprint4-dev-001"
#   loadbalancer_id    = azurerm_lb.main.id
# #   virtual_network_id = azurerm_virtual_network.main.id
# }

# # Linux Virtual Machine Scale Set
# resource "azurerm_linux_virtual_machine_scale_set" "main" {
#   name                 = "vmss-sprint4-dev-001"
#   location             = data.azurerm_resource_group.main.location
#   resource_group_name  = data.azurerm_resource_group.main.name
#   admin_username       = var.admin.username
#   sku                  = "Standard_B1s"
#   instances            = 2
#   computer_name_prefix = "vm"
#   zone_balance         = true
#   zones                = [var.zones[0], var.zones[1]]

#   network_interface {
#     name    = "nic-01-vmss-sprint4-002"
#     primary = true

#     ip_configuration {
#       name                                   = "external"
#       primary                                = true
#       subnet_id                              = azurerm_virtual_network.main.subnet.*.id[0]
#       load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.main.id]
#     #   public_ip_address {
#     #     name = "pip-vmss-sprint4-002"
#     #   }

#     }
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   data_disk {
#     caching              = "ReadWrite"
#     disk_size_gb         = 10
#     lun                  = 1
#     storage_account_type = "Standard_LRS"
#     # name                 = "vmss_sprint4_dev_001"
#   }

#   admin_ssh_key {
#     username   = var.admin.username
#     public_key = file("C:\\Users\\Lawal\\.ssh\\id_rsa.pub")
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-focal"
#     sku       = "20_04-LTS"
#     version   = "latest"
#   }
# }