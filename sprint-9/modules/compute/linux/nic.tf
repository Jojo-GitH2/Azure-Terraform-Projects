resource "azurerm_network_interface" "primary" {
  name                = "nic-${var.virtual_machine.name}"
  location            = var.virtual_machine.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "ipconfig-${azure_virtual_machine.main.name}"
    subnet_id                     = var.virtual_machine.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.enable_public_ip ? azurerm_public_ip.this[0].id : null
  }

  dynamic "public_ip_address" {
    for_each = var.enable_public_ip ? [1] : []
    content {
      name                = "pip-${var.virtual_machine.name}"
      location            = var.virtual_machine.location
      resource_group_name = var.resource_group_name
      allocation_method   = var.public_ip.allocation_method
      sku                 = var.public_ip.sku
      tags                = var.tags
      sku_tier            = var.public_ip.sku_tier
    }

  }
}
