resource "azurerm_orchestrated_virtual_machine_scale_set" "main" {
  name                        = "ovmss-sprint4-dev-001"
  location                    = data.azurerm_resource_group.main.location
  resource_group_name         = data.azurerm_resource_group.main.name
  platform_fault_domain_count = 1
  instances                   = 2
  zones = ["2", "3"]
  #   zone_balance = 

}

# resource "azurerm_availability_set" "main" {
#   name                = "avset-sprint4-dev-001"
#   resource_group_name = data.azurerm_resource_group.main.name
#   location            = data.azurerm_resource_group.main.location

# }

