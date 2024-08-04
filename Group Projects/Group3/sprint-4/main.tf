data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

module "network" {
  source              = "./modules/network_security"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}

module "webTier" {
  source                    = "./modules/webTier"
  subnet_id                 = module.network.subnet_ids[0]
  network_security_group_id = module.network.security_group_ids[0]
  location                  = data.azurerm_resource_group.main.location
  resource_group_name       = data.azurerm_resource_group.main.name
  admin_username            = var.admin_username
}

# module "appTier" {
#   source                    = "./modules/appTier"
#   subnet_id                 = module.network.subnet_ids[1]
#   network_security_group_id = module.network.security_group_ids[1]
#   location                  = data.azurerm_resource_group.main.location
#   resource_group_name       = data.azurerm_resource_group.main.name
#   admin_password            = var.admin_password
#   admin_username            = var.admin_username

# }

# module "dbTier" {
#   source                    = "./modules/dbTier"
#   subnet_id                 = module.network.subnet_ids[2]
#   network_security_group_id = module.network.security_group_ids[2]
#   location                  = data.azurerm_resource_group.main.location
#   resource_group_name       = data.azurerm_resource_group.main.name
#   admin_password            = var.admin_password
#   admin_username            = var.admin_username

# }

