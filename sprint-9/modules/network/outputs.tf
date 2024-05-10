output "subnet_ids" {
  value       = { for k, subnet in azurerm_subnet.this : k => { id = subnet.id, address_prefixes = subnet.address_prefixes }}
  description = "The IDs and address prefixes of the subnets"
}
