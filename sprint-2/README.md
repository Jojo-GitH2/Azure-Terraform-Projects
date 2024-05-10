[Home](../README.md) | [Sprint 1](README.md)

---

<p align="right">
    <img src="../.assets/logo-02.png" width="140x" />
</p>

# Knixat Cloud DevOps - Sprint 2
## Applying and Managing Tags on Azure Resources in the Azure Portal
**Step 1:** Sign in to the Azure Portal

- Open a web browser and navigate to the Azure Portal.
- Sign in with your Azure account credentials.

**Step 2:** Navigate to your Resource Group

- Once you're logged in, locate and click on "Resource groups" in the left-hand menu.
- Select the resource group containing the resources you want to tag.

**Step 3:** Select a Resource

- Inside the selected resource group, you will see a list of resources. 
- Click on the resource you want to tag.

**Step 4:** Access the Tags Section

- In the resource's overview page, find and click on the "Tags" tab in the left-hand menu.

**Step 5:** Add Tags

- Click the "Add tag" button.
- In the "Name" field, enter a tag name (e.g., "Department," "Environment," "Project," etc.).
- In the "Value" field, enter the corresponding value for the tag (e.g., "HR," "Development," "ProjectA," etc.).
- Click the "Save" button to add the tag.

**Step 6:** Edit or Delete Tags (Optional)

- To edit a tag, click on the existing tag, make your changes, and click "Save."
- To delete a tag, click the "X" icon next to the tag.

**Step 7:** Apply Tags to Multiple Resources (Optional)

- If you want to apply the same tag to multiple resources in the same resource group, you can do so from the resource group's "Tags" section.
- Select multiple resources using the checkboxes next to each resource.
- Click the "Add tag" button, and then follow the same steps as in Step 5 to add tags to all selected resources simultaneously.

**Step 8:** View and Filter by Tags

- To view and filter resources by tags, go back to the resource group's overview page.
- Click the "Tags" tab to see a list of tags used in that resource group.
- Click on a tag to see all resources with that specific tag.

**Step 9:** Modify Tags Over Time

- As your resource usage evolves, you can easily modify or add new tags to keep your resources well-organized and categorized.

**Step 10:** Automate Tagging (Optional)

- You can also automate tagging using Azure Policy, Azure Resource Manager templates, or Azure PowerShell scripts to enforce tagging standards across your organization.

## Applying and Managing Tags on Azure Resources using the Azure CLI
**Step 1:** Install and Set Up Azure CLI

- If you haven't already, install the Azure CLI on your local machine. You can download it from the official Azure CLI installation page.

**Step 2:** Sign In to Your Azure Account

- Open a command prompt or terminal window.
- Run the following command to sign in to your Azure account:

    ```bash
    az login
    ```
    
- Follow the on-screen instructions to complete the authentication process.

**Step 3:** Select the Resource Group and Resource

- You'll need to know the name of the resource group containing the resource you want to tag and the name of the resource itself.

**Step 4:** Apply Tags to a Resource

- To apply tags to a specific resource, use the ```az resource``` tag command. Replace **\<resource-group-name>**, **\<resource-name>,** **\<tag-name>**, and **\<tag-value>** with your specific values.
  
    ```bash
    az resource tag --tags <tag-name>=<tag-value> --resource-group <resource-group-name> --name <resource-name> --resource-type <resource-type>
    ```
- **\<resource-type>** can typically be determined by looking at the resource's documentation or by examining the resource in the Azure Portal.

**Step 5:** View Tags for a Resource

- To view the tags associated with a specific resource, use the az resource show command. Replace **\<resource-group-name>** and **\<resource-name>** with your specific values.

    ```bash
    az resource show --resource-group <resource-group-name> --name <resource-name> --resource-type <resource-type> --query tags
    ```

**Step 6:** Modify or Remove Tags

- To modify an existing tag, simply re-run the ```az resource``` tag command with the new values.
- To remove a tag, use the ```az resource``` tag remove command. Replace **\<resource-group-name>**, **\<resource-name>**, and **\<tag-name>** with your specific values.

    ```bash
    az resource tag remove --resource-group <resource-group-name> --name <resource-name> --resource-type <resource-type> --tags <tag-name>
    ```
- You can also remove all tags from a resource by omitting the ```--tags``` parameter.

**Step 7:** Automate Tagging (Optional)

- You can automate tagging using Azure Resource Manager templates, Azure PowerShell scripts, or other automation tools to enforce tagging standards across your resources.

## Assignment of Built-in Policy to Resource Group
[Terraform Configuration Files](../.assets/sprint-2/terraform%20codes/assign-builtin-policy/)
> Due to the `.gitignore` file, some files are not visible in the repository. See the Screenshots [here](../.assets/sprint-2/images/Screenshot%20(104).png)

## Deny Storage Account Creation without my Initials

[Terraform Configuration Files](../.assets/sprint-2/terraform%20codes/storage-account-policy/)

> Due to the `.gitignore` file, some files are not visible in the repository. See the Screenshots [here](../.assets/sprint-2/images/Screenshot%20(104).png)

## Screenshots
### Creating a Storage Account without my Initials


![Screenshot 1](../.assets/sprint-2/images/Screenshot%20(98).png)

![Screenshot 2](../.assets/sprint-2/images/Screenshot%20(99).png)

### Creating a Storage Account with my Initials

![Screenshot 3](../.assets/sprint-2/images/Screenshot%20(100).png)

![Screenshot 4](../.assets/sprint-2/images/Screenshot%20(101).png)

![Screenshot 5](../.assets/sprint-2/images/Screenshot%20(102).png)

![Screenshot 6](../.assets/sprint-2/images/Screenshot%20(103).png)

### Bypassing the Policy with an Exemption
## Creating a Custom RBAC Role in Azure

### 1. Determine the permissions you need
Azure has thousands of permissions that you can potentially include in your custom role. Here are some methods that can help you determine the permissions you will want to add to your custom role:
- Look at existing built-in roles.
- List the Azure services you want to grant access to.
- Determine the resource providers that map to the Azure services.
  
In most cases, you will need permissions such as Owner or User Access Administrator.

### 2. Choose how to start
There are three ways that you can start to create a custom role. You can:
- [Clone an existing role: If an existing role does not quite have the permissions you need, you can clone it and then modify the permissions.](https://learn.microsoft.com/en-us/azure/role-based-access-control/custom-roles)
- [Start from scratch: If you prefer, you can start a custom role from scratch.](https://learn.microsoft.com/en-us/azure/role-based-access-control/custom-roles)
- [Start with a JSON file: You can also start with a JSON file.](https://learn.microsoft.com/en-us/azure/role-based-access-control/custom-roles)

### 3. Create the custom role
You can create custom roles using the Azure portal, Azure PowerShell, Azure CLI, or the REST API.

#### Using Azure Portal
Here is an example of how you can create a custom role in the Azure portal:

```json
{
  "Name": "Custom Role",
  "Id": null,
  "IsCustom": true,
  "Description": "Allows for read access to Azure Storage and restart/start/stop of virtual machines.",
  "Actions": [
    "Microsoft.Storage/*/read",
    "Microsoft.Compute/*/read",
    "Microsoft.Compute/virtualMachines/start/action",
    "Microsoft.Compute/virtualMachines/restart/action",
    "Microsoft.Compute/virtualMachines/powerOff/action"
  ],
  "NotActions": [],
  "AssignableScopes": [
    "/subscriptions/{subscriptionId1}",
    "/subscriptions/{subscriptionId2}",
    "/subscriptions/{subscriptionId3}"
  ]
}
```
In this example, replace `{subscriptionId1}`, `{subscriptionId2}`, and `{subscriptionId3}` with your actual subscription IDs.

#### Using Azure PowerShell
You can also use Azure PowerShell to create a custom role. Here is an example:

```powershell
$role = Get-AzRoleDefinition "Reader"
$role.Id = $null
$role.Name = "Reader Plus"
$role.Description = "Can read and restart virtual machines."
$role.Actions.Add("Microsoft.Compute/*/read")
$role.Actions.Add("Microsoft.Compute/virtualMachines/start/action")
$role.Actions.Add("Microsoft.Compute/virtualMachines/restart/action")
New-AzRoleDefinition -Role $role
```
In this example, we're creating a new role called "Reader Plus" that has all the permissions of the built-in Reader role plus the ability to start and restart virtual machines.

#### Using Azure CLI
You can also use Azure CLI to create a custom role. Here is an example:

```bash
az role definition create --role-definition '{
    "Name": "Virtual Machine Operator",
    "Description": "Can monitor and restart virtual machines.",
    "Actions": [
        "Microsoft.Storage/*/read",
        "Microsoft.Network/*/read",
        "Microsoft.Compute/*/read",
        "Microsoft.Compute/virtualMachines/start/action",
        "Microsoft.Compute/virtualMachines/restart/action"
    ],
    "DataActions": [],
    "NotActions": [],
    "AssignableScopes": ["/subscriptions/{subscriptionId}"]
}'
```
In this example, replace `{subscriptionId}` with your actual subscription ID.

#### Using REST API
You can also use REST API to create a custom role. Here is an example:

```http
PUT https://management.azure.com/subscriptions/{subscriptionId}/providers/Microsoft.Authorization/roleDefinitions/{roleId}?api-version=2015-07-01

{
  "properties": {
    "roleName": "Virtual Machine Operator",
    "description": "",
    "type": "",
    "permissions": [
      {
        "actions": [
          "*"
        ],
        "notActions": []
      }
    ],
    "assignableScopes": [
      "/subscriptions/{subscriptionId}"
    ]
  }
}
```
In this example, replace `{subscriptionId}` and `{roleId}` with your actual subscription ID and role ID.

## 4. Test the custom role
Once you have your custom role, you have to test it to verify that it works as expected. You can test your custom role using the Azure portal, Azure PowerShell, Azure CLI, or the REST API.







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
