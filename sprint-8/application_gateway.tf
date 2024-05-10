resource "azurerm_public_ip" "main" {
  name                = var.public_ip_name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = var.zones

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_application_gateway" "main" {
  name                = var.application_gateway.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  zones               = var.zones

  sku {
    name = var.application_gateway.sku.name
    tier = var.application_gateway.sku.tier
  }

  autoscale_configuration {
    min_capacity = 2
    max_capacity = 5
  }

  gateway_ip_configuration {
    name      = local.gateway_ip_configuration_name
    subnet_id = azurerm_virtual_network.main.subnet.*.id[0]
  }

  frontend_port {
    name = local.frontend_port_name
    port = var.application_gateway.frontend_port.port
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.main.id
  }

  backend_address_pool {
    name  = local.backend_address_pool_name
    fqdns = ["${azurerm_linux_web_app.main.name}.azurewebsites.net"]
  }

  backend_http_settings {
    name = local.http_setting_name
    # probe_name            = local.probe_name
    cookie_based_affinity               = "Disabled"
    path                                = "/"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 120
    pick_host_name_from_backend_address = true
  }

  probe {
    name = local.probe_name
    # host                = "${azurerm_linux_web_app.main.name}.azurewebsites.net"
    path                                      = "/"
    protocol                                  = "Http"
    interval                                  = 30
    timeout                                   = 120
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = 100
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Detection"
    rule_set_version = "3.1"

  }
}

