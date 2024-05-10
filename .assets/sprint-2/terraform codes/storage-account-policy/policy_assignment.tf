# Terraform code to create a policy assignment for storage account naming convention.

resource "azurerm_resource_group_policy_assignment" "storage_account_naming_assignment" {
  name                 = "storage-account-naming-assignment"
  policy_definition_id = azurerm_policy_definition.storage_account_naming_policy.id
  resource_group_id    = var.cust_scope
  display_name         = "Storage Account Naming Assignment"
  description          = "Enforce storage account naming convention."
  depends_on           = [azurerm_policy_definition.storage_account_naming_policy]



  
}
