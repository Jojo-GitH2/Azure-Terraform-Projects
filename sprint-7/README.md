[Home](README.md) | [Sprint 1](./sprint-1/README.md) | [Sprint 2](./sprint-2/README.md) | [Sprint 3](./sprint-3/README.md) | [Sprint 4](./sprint-4/README.md) | [Sprint 5](./sprint-5/README.md) 

---

<p align="right">
    <img src="./.assets/logo-02.png" width="140x" />
</p>

# Knixat Cloud DevOps - Sprint 7

## Deploy a Static Website to Azure Storage
### URL
[Static Website](https://ststaticwebjonah001.z20.web.core.windows.net/)
### Step 1: Specify Providers and Run Terraform Init
First, specify the required providers in your Terraform configuration. In your case, you're using the `azurerm` provider. Once you've specified the providers, run `terraform init` in your terminal to initialize your Terraform workspace and download the necessary provider plugins.

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.77.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
```

### Step 2: Read the Resource Group from Azure
Next, use the `azurerm_resource_group` data source to read the details of an existing resource group from Azure.

```hcl
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}
```

### Step 3: Create Storage Account and Enable Static Website
Then, create a new storage account and enable static website hosting on it using the `azurerm_storage_account` resource.

```hcl
resource "azurerm_storage_account" "main" {
  name                     = var.storage_account.name
  account_tier             = var.storage_account.account_tier
  account_replication_type = var.storage_account.account_replication_type
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}
```

### Step 4: Read $web Container from the Created Account Using Data Block
After creating the storage account, read the `$web` container from it using the `azurerm_storage_container` data source.

```hcl
data "azurerm_storage_container" "main" {
  name                 = var.storage_account.containers[0].name
  storage_account_name = azurerm_storage_account.main.name
}
```

### Step 5: Upload the Folder Containing All Files for the Static Website
Finally, upload all files for your static website to the `$web` container in your storage account using the `azurerm_storage_blob` resource.

```hcl
resource "azurerm_storage_blob" "website" {
  # Upload all files in the "web" folder  
  for_each = fileset("${path.module}/web", "**/*")

  name                   = each.key
  storage_account_name   = azurerm_storage_account.main.name
  storage_container_name = var.storage_account.containers[0].name
  type                   = "Block"
  
  source                 = "${path.module}/web/${each.key}"
  # Set content type for each file so that it can render correctly in the browser
  content_type = lookup({
    ".html" = "text/html"
    ".css"  = "text/css"
    ".js"   = "application/javascript"
  }, format(".%s", element(split(".", each.key), length(split(".", each.key)) - 1)), "application/octet-stream")
}
```

### Step 6: Output the Primary Endpoint of the Static Website
Once the static website is deployed, output the primary endpoint of the static website using the `azurerm_storage_account` data source.

```hcl
output "primary_endpoint" {
  value = azurerm_storage_account.main.primary_web_endpoint
}
```
## Document the Steps for Configuring Network Access

1. **Disable all public network access**: This is the first step in securing your storage account. You can disable all public network access for the storage account under the Public network access setting in the storage account firewall. This means that no one can access your storage account from the public internet.

2. **Configure private links**: Private links provide secure connectivity between clients on your virtual network and your storage account. You can configure private links to your storage account from private endpoints on virtual network subnets where the clients reside that require access to your data.

3. **Enable Azure Storage firewalls and virtual networks**: Network rules add an extra layer of security. When you configure network rules, only applications that request data over the specified set of networks or through the specified set of Azure resources can access a storage account.

4. **Limit access**: You can limit access to your storage account to requests that come from specified IP addresses, IP ranges, subnets in an Azure virtual network, or resource instances of some Azure services. This helps to ensure that only authorized users and applications can access your storage account.

5. **Create private endpoints**: Private endpoints provide secure connectivity between clients on your virtual network and your storage account. Creating private endpoints assigns a private IP address from your virtual network to the storage account, ensuring that traffic between your virtual network and the service travels across the Microsoft backbone network.

6. **Configure Azure Storage firewall**: The Azure Storage firewall provides access control for the public endpoint of your storage account. You can use the firewall to block all access through the public endpoint when you're using private endpoints.

7. **Enable trusted Azure platform services**: Your firewall configuration also enables trusted Azure platform services to access the storage account. This allows services like Azure Backup or Azure Site Recovery to access your storage account even if it's locked down with network rules.

8. **Authorize requests**: An application that accesses a storage account when network rules are in effect still requires proper authorization for the request. This could be a Shared Key, shared access signature (SAS), or Azure Active Directory (Azure AD) token.

9. **Enable Microsoft.Storage service endpoint**: Service endpoints provide secure connectivity between clients on your virtual network and your storage account. Enable the Microsoft.Storage service endpoint on the subnet where your storage account is located.

10. **Allow access from private endpoint's IP address**: Configure the storage account firewall to allow access from the private endpoint's IP address. This ensures that only traffic from this IP address can reach your storage account.

11. **Restrict default internet access**: By default, a storage account accepts connections from clients on any network. To limit access to selected networks, you must first change this default behavior.

12. **Enable firewall rules**: After you've restricted default internet access, you can create rules that grant access to selected networks or IP addresses.

13. **Limit network access to specific networks**: You can limit network access to specific networks by creating rules that grant access only to these networks.

14. **Allow trusted Microsoft services**: Some Microsoft services that interact with storage accounts operate from networks that can't be granted access through network rules. To enable these services to work with network rules, you must allow trusted Microsoft services.

15. **Enable Secure transfer required option**: The Secure transfer required option enhances the security of your data by only allowing requests to the storage service over a secure connection.

16. **Limit shared access signature (SAS) tokens**: Limit shared access signature (SAS) tokens to HTTPS connections only. This ensures that SAS tokens are only transmitted over secure connections.

## Use Azure Storage Explorer to perform various operations on storage resources

![Screenshot #1](./images/Screenshot%20(181).png)
![Screenshot #2](./images/Screenshot%20(182).png)
![Screenshot #3](./images/Screenshot%20(183).png)
![Screenshot #4](./images/Screenshot%20(184).png)


## Document the process of data copy operations with AZCopy

1. **Install AZCopy**: First, you need to install AZCopy on your machine. You can download it from the official Microsoft website.

2. **Authenticate with Azure Storage**: Before you can copy data, you need to authenticate with Azure Storage. You can do this by using the `azcopy login` command and following the prompts.

3. **Perform the Copy Operation**: Once you're authenticated, you can perform the copy operation. The basic syntax for copying data is `azcopy cp [source] [destination]`. Here's an example:

    ```bash
    azcopy cp "https://[account].blob.core.windows.net/[source-container]/[path-to-source-file]" "https://[account].blob.core.windows.net/[destination-container]/[path-to-destination-file]"
    ```

    Replace `[account]`, `[source-container]`, `[path-to-source-file]`, `[destination-container]`, and `[path-to-destination-file]` with your actual values.

4. **Verify the Copy Operation**: After the copy operation is complete, AZCopy will display a summary that includes the number of files transferred and the total amount of data transferred. You can also verify the copy operation by checking the destination in Azure Storage Explorer.

---

<p align="left">
    <img src="../.assets/logo-03.png" width="50x" />
</p>

**Contact Us:**  
Email: [admissions@knixat.com](mailto:admissions@email.com)  
Website: [www.knixat.com](https://www.knixat.com)

&copy; 2023 Knixat. All Rights Reserved.

---

[Home](README.md) | [Sprint 1](./sprint-1/README.md)
