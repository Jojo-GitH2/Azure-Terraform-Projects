output "subnets" {
  value = azurerm_virtual_network.main.subnet.*.id

}

output "subnet" {
  value = azurerm_virtual_network.main.subnet
}