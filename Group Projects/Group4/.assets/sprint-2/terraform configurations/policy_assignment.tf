# Terraform Resource: azurerm_policy_assignment

resource "azurerm_resource_group_policy_assignment" "this" {
  name                 = "deny-virtual-machines-with-public-ip-assignment"
  policy_definition_id = azurerm_policy_definition.this.id
  resource_group_id    = var.cust_scope
  display_name         = "Deny Virtual Machines  with Public IP Assignment"
  description          = "Deny Virtual Machines  with Public IP Assignment"
  depends_on           = [azurerm_policy_definition.this]


}

resource "azurerm_resource_group_policy_assignment" "storage_account-public_access" {
  name                 = "storage-account-public-access"
  policy_definition_id = azurerm_policy_definition.storage_account-public_access.id
  resource_group_id    = var.cust_scope
  display_name         = "Deny the creation of storage accounts with public access"
  description          = "Deny the creation of storage accounts with public access"
  depends_on           = [azurerm_policy_definition.storage_account-public_access]


}

