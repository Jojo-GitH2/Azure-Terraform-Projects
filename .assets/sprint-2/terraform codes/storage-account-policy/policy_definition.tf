resource "azurerm_policy_definition" "storage_account_naming_policy" {
  name         = "storage-account-naming-policy"
  display_name = "Enforce Initials in Storage Account Names"
  description  = "Deny the creation of storage accounts with incorrect initials in the name."
  policy_type  = "Custom"
  mode         = "All"

  metadata = <<METADATA
  {
    "category" : "Custom"
  }
  METADATA

  policy_rule = <<POLICY_RULE
  {
    "if": {
      "allOf": [
        {
          "field": "type",
          "equals": "Microsoft.Storage/storageAccounts"
        },
        {
          "not": {
            "field": "name",
            "like": "[concat(parameters('initials'), '*')]"
          }
        }
      ]
    },      
      "then" : {
        "effect" : "deny"
      }
  }
  POLICY_RULE

  parameters = <<PARAMETERS
  {
    "initials": {
      "type": "String",
      "defaultValue": "ju",
      "metadata": {
        "displayName": "Initials",
        "description": "Your initials (e.g., gj for Gabriel John)"
      }
    }
  }
  PARAMETERS

}

