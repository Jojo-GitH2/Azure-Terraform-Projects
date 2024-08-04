# Create Network Resources
resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.location}-3-tier"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]

  tags = {
    NetworkType = "multi-tier"
  }
}

# resource "azurerm_subnet" "this" {
#   name = "${var.tiers[count.index]}-subnet-${var.location}"
#   address_prefixes = ["10.0.${count.index + 1}.0/24"]
# }

# Create 3 subnets for the 3 tiers
resource "azurerm_subnet" "this" {
  count                = length(var.tiers)
  name                 = "${var.tiers[count.index]}-subnet-${var.location}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.${count.index + 1}.0/24"]
  depends_on           = [azurerm_virtual_network.main]
}



