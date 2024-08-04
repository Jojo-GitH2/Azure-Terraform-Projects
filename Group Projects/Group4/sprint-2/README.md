[Home](../README.md) | [Sprint 1](README.md)

---

<p align="right">
    <img src="../.assets/logo-02.png" width="140x" />
</p>

# Knixat Cloud DevOps - Sprint 1

## Discuss and Present the Azure Policy Created in Individual Story

**Policy Name:** Storage Account Naming Policy

**Description:** This Azure policy is designed to enforce naming conventions for storage accounts within a specified resource group. Specifically, it ensures that storage account names must begin with the initials of the person's name and be followed by a unique name.

```json
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
  "then": {
    "effect": "deny"
  }
}
```
**Explanation:**

**Policy Condition:**

- The policy is triggered when a storage account is being created or modified within the specified resource group.
  
**Policy Enforcement:**

- It checks if the storage account name (represented by the "name" field) matches the expected pattern.
- The pattern is defined as the first two characters (initials) of a person's name using the `concat(parameters('initials'), '*')` function.
- If the storage account name does not match this pattern, the policy effect is set to "deny."
  
## Simulated Access Assignments - "Reader" Role for Gabriel Adesanya

**Scenario**:
- User: Gabriel Adesanya
- Role Assigned: Reader
- Resource: Virtual Machine (VM)
- Resource Name: Sprint-2 VM

![](../.assets/sprint-2/images/Screenshot%20(112).png)

**Implications**:

1. **Virtual Machine Access**:
   - As a Reader, Gabriel Adesanya can view the details of the "Sprint-2 VM" Virtual Machine.
   - He can check the properties of the VM, such as its name, size, status, and associated virtual networks.

2. **Configuration and Settings**:
   - Gabriel can access and review the configuration and settings of the "Sprint-2 VM." This includes details like OS disk, data disks, network interfaces, and diagnostic settings.

3. **Read-Only Access**:
   - His access is read-only, meaning he can only view the configuration and settings but cannot make any changes.

4. **No Management Privileges**:
   - The "Reader" role does not grant Gabriel the ability to start, stop, delete, or manage the "Sprint-2 VM."
   - He cannot create new virtual machines, modify existing configurations, or perform any actions that affect the VM's operation.

5. **No Access to Secrets or Keys**:
   - Gabriel Adesanya does not have access to sensitive information like secret keys, passwords, or secure certificates associated with the VM.

6. **Single Resource Access**:
   - His access is limited to the "Sprint-2 VM" only. Gabriel cannot access or view resources in other resource groups or virtual machines unless similar access assignments are made.

7. **Audit and Monitoring**:
   - Azure maintains logs of activities performed by users with the "Reader" role. These logs can be reviewed by administrators for security and compliance purposes.

8. **Role Limitations**:
   - It's important to note that while "Reader" grants read-only access, certain activities might still be restricted if other policies or RBAC roles are in place. For example, if a policy prohibits the creation of public IP addresses, Gabriel won't be able to create them even though he has read access.

## Create Policy to Block Public Access to Storage Accounts and to Block Provisioning of VMs with Public IP Addresses

> [Terraform Configuration](../.assets/sprint-2/terraform%20configurations/)

### Screenshots

![Screenshot 1](<../.assets/sprint-2/images/Screenshot%20(105).png>)

![Screenshot 2](<../.assets/sprint-2/images/Screenshot%20(106).png>)

![Screenshot 3](<../.assets/sprint-2/images/Screenshot%20(107).png>)

![Screenshot 4](<../.assets/sprint-2/images/Screenshot%20(108).png>)

![Screenshot 5](<../.assets/sprint-2/images/Screenshot%20(109).png>)

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
