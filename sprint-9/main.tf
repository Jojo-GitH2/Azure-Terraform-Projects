module "network" {
  for_each            = var.virtual_networks
  source              = "./modules/network"
  resource_group_name = data.azurerm_resource_group.main.name

  virtual_network = {
    name          = each.key
    address_space = each.value.address_space
    location      = each.value.location
    subnets       = each.value.subnets
  }

  tags = var.tags
}

# module "compute_linux" {
#   for_each = var.virtual_networks.
#   source = "./modules/compute/linux"
#   resource_group_name = data.azurerm_resource_group.main.name

#   virtual_machine = {
#     name = each.key
#     location = each.value.location
#     size = each.value.size
#     admin_username = each.value.admin_username
#     public_key = each.value.public_key
#     os_disk = {
#       caching = each.value.os_disk.caching
#       storage_account_type = each.value.os_disk.storage_account_type
#     }
#     source_image_reference = {
#       publisher = each.value.source_image_reference.publisher
#       offer = each.value.source_image_reference.offer
#       sku = each.value.source_image_reference.sku
#       version = each.value.source_image_reference.version
#     }
#   }

#   enable_public_ip = var.enable_public_ip

#   public_ip = {
#     allocation_method = 
#   }
#   tags = var.tags
# }