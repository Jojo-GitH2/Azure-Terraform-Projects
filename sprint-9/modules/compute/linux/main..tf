resource "azurerm_linux_virtual_machine" "this" {
  name                = var.virtual_machine.name
  resource_group_name = var.resource_group_name
  location            = var.virtual_machine.location
  size                = var.virtual_machine.size
  admin_username      = var.virtual_machine.admin_username

  network_interface_ids = [azurerm_network_interface.primary.id]

  admin_ssh_key {
    username   = var.virtual_machine.admin_username
    public_key = file(var.virtual_machine.public_key)
  }

  os_disk {
    caching              = var.virtual_machine.os_disk.caching
    storage_account_type = var.virtual_machine.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.virtual_machine.source_image_reference.publisher
    offer     = var.virtual_machine.source_image_reference.offer
    sku       = var.virtual_machine.source_image_reference.sku
    version   = var.virtual_machine.source_image_reference.version
  }

  tags = var.tags
}