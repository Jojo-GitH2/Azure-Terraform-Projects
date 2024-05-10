[Home](../README.md) | [Sprint 1](README.md)

---

<p align="right">
    <img src="../.assets/logo-02.png" width="140x" />
</p>

# Knixat Cloud DevOps - Sprint 3

## Configure VNEts with 3 Subnets

[Configuration files](../.assets/sprint-3/terraform%20configuration%20files/Configure%20VNets%20wth%203%20subnets/)

## Steps for creating security rules with NSGs.

### Azure Portal

1. **Create a Network Security Group (NSG):**

   - In the Azure portal, search for "Network security group" and select it.
   - Click on "+ Create".
   - Fill in the details such as Name, Subscription, Resource group, and Location.

2. **Create Inbound and Outbound Security Rules:**
   - Select your NSG from the list of NSGs.
   - For inbound rules, select "Inbound security rules". For outbound rules, select "Outbound security rules".
   - Click on "Add" to create a new rule.
   - For each rule, you can specify source and destination, port, and protocol.

### Azure CLI

You can use the `az network nsg` command to manage Azure Network Security Groups (NSGs). Here's an example of how to create a network security group and a rule:

```bash
# Create a network security group
az network nsg create --name myNsg --resource-group myResourceGroup

# Create a network security group rule
az network nsg rule create --name myNsgRule --nsg-name myNsg --priority 400 \
--source-address-prefixes VirtualNetwork --destination-address-prefixes Storage \
--destination-port-ranges '*' --direction Outbound --access Allow --protocol Tcp \
--description "Allow VirtualNetwork to Storage."
```

### Azure PowerShell

You can use the `New-AzNetworkSecurityGroup` and `New-AzNetworkSecurityRuleConfig` cmdlets to create a network security group and a rule:

```powershell
# Create a network security group
$myNsg = New-AzNetworkSecurityGroup -ResourceGroupName myResourceGroup -Location "East US" -Name myNsg

# Place the network security group configuration into a variable.
$networkSecurityGroup = Get-AzNetworkSecurityGroup -Name myNSG -ResourceGroupName myResourceGroup

## Create the security rule.
Add-AzNetworkSecurityRuleConfig -Name RDP-rule -NetworkSecurityGroup $networkSecurityGroup `
-Description "Allow RDP" -Access Allow -Protocol Tcp -Direction Inbound -Priority 300 `
-SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389

## Updates the network security group.
Set-AzNetworkSecurityGroup -NetworkSecurityGroup $networkSecurityGroup

## Place the network security group configuration into a variable.
$networkSecurityGroup = Get-AzNetworkSecurityGroup -Name myNSG -ResourceGroupName myResourceGroup

## List security rules of the network security group in a table. ##
Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $networkSecurityGroup | format-table Name, Protocol, Access, Priority, Direction, SourcePortRange, DestinationPortRange, SourceAddressPrefix, DestinationAddressPrefix
```
### Terraform
You can use the `azurerm_network_security_group` and `azurerm_network_security_rule` resources to create a network security group and a rule:

```terraform
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
```

## Hub-and-Spoke Architecture
### Architecture Diagram
![Hub-and-Spoke Architecture](../.assets/sprint-3/images/hub-spoke-network-topology-architecture%20(1).jpg)

### Terraform Configuration

[Configuration files](../.assets/sprint-3/terraform%20configuration%20files/Hub-Spoke%20Topology/])

---

<p align="left">
    <img src="../.assets/logo-03.png" width="50x" />
</p>

**Contact Us:**  
Email: [admissions@knixat.com](mailto:admissions@email.com)  
Website: [www.knixat.com](https://www.knixat.com)

&copy; 2023 Knixat. All Rights Reserved.

---

[Home](../README.md) | [Sprint 1](README.md)
