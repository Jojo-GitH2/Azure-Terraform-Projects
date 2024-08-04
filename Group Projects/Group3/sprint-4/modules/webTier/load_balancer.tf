resource "azurerm_public_ip" "this" {
  name                = "pip-weblb-dev-${var.location}-001"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_lb" "main" {
  name                = "lb-web-dev-001"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  #   depends_on          = [azurerm_linux_virtual_machine_scale_set.main]

  frontend_ip_configuration {
    name = "PublicIPAddress"
    # zones = ["2", "3"]
    public_ip_address_id = azurerm_public_ip.this.id
  }

}

resource "azurerm_lb_backend_address_pool" "main" {
  name            = "lb-backend-pool-vmss-sprint4-dev-001"
  loadbalancer_id = azurerm_lb.main.id
}

resource "azurerm_lb_probe" "main" {
  name            = "lb-probe-vmss-sprint4-dev-001"
  loadbalancer_id = azurerm_lb.main.id
  port            = 80
  protocol        = "Tcp"
  request_path    = ""

}

resource "azurerm_lb_rule" "http" {
  loadbalancer_id                = azurerm_lb.main.id
  name                           = "AllowHTTP"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
}

# module "loadbalancer" {
#   source              = "Azure/loadbalancer/azurerm"
#   version             = "4.4.0"
#   resource_group_name = var.resource_group_name
#   allocation_method   = "Static"
#   lb_sku              = "Standard"
#   location            = var.location

#   frontend_ip_zones = ["2", "3"]

#   frontend_name = "PublicIPAddress"

#   pip_name = azurerm_public_ip.this.name

#   remote_port = {
#     ssh = ["Tcp", "22"]
#   }

#   lb_port = {
#     http = ["80", "Tcp", "80"]
#   }

#   lb_probe = {
#     http = ["Tcp", "80", "/"]
#   }

# }