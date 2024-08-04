resource "azurerm_policy_definition" "this" {
  name         = "pip-virtual-machine-block"
  display_name = "Deny the creation of virtual machines with public IP addresses "
  description  = "Deny the creation of virtual machines with public IP addresses "
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
            "equals": "Microsoft.Network/networkInterfaces",
            "field": "type"
          },
          {
            "not": {
              "field": "Microsoft.Network/networkInterfaces/ipConfigurations[*].publicIpAddress.id",
              "notLike": "*"
            }
          }
      ]
    },      
      "then" : {
        "effect" : "deny"
      }
  }
  POLICY_RULE
}

resource "azurerm_policy_definition" "storage_account-public_access" {
  name         = "storage-account-public-access"
  display_name = "Deny the creation of storage accounts with public access"
  description  = "Deny the creation of storage accounts with public access"
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
            "field": "Microsoft.Storage/storageAccounts/publicNetworkAccess",
            "notEquals": "Disabled"
          }
        
      ]
    },      
      "then" : {
        "effect" : "deny"
      }
  }
  POLICY_RULE

}
