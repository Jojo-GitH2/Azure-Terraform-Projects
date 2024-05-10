[Home](../README.md) | [Sprint 1](README.md)

---

<p align="right">
    <img src="../.assets/logo-02.png" width="140x" />
</p>

# Knixat Cloud DevOps - Sprint 5

## Deploy a simple web application using Azure App Service(with Terraform) and document the deployment process.

### Links
- [Prod](https://app-python-jonah-prod-001.azurewebsites.net)
<!-- - [Staging](https://app-python-jonah-prod-001-staging.azurewebsites.net/) -->
- [Web App Repo](https://github.com/Jojo-GitH2/msdocs-python-django-webapp-quickstart)

**Prerequisites**

- Azure subscription: If you don’t have an Azure subscription, create a free account before you begin.
- Configure Terraform

**1. Define the Resource Group and Service Plan**

```hcl
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_service_plan" "main" {
  name                = var.app_service_plan_name
  resource_group_name = data.azurerm_resource_group.main.name
}
```

**2. Create Production Web App**

```hcl
resource "azurerm_linux_web_app" "main" {
  location            = data.azurerm_service_plan.main.location
  name                = "app-python-jonah-prod-001"
  resource_group_name = data.azurerm_resource_group.main.name
  service_plan_id     = data.azurerm_service_plan.main.id

  site_config {
    ftps_state = "AllAllowed"
    application_stack {
      python_version = "3.9"
    }
    health_check_path = "/"
  }

  logs {
    application_logs {
      file_system_level = "Information"
    }
  }
}
```

**3. Create Staging Web App in a Deployment Slot**

```hcl
resource "azurerm_linux_web_app_slot" "main" {
  name           = "staging"
  app_service_id = azurerm_linux_web_app.main.id

  site_config {
    ftps_state = "AllAllowed"
    application_stack {
      python_version = "3.9"
    }
    health_check_path = "/"
  }
}
```

**4. Deploy Code from a GitHub Repo to Production and Staging**

You can deploy code from a GitHub repo to both production and staging using the following terraform code:

```hcl
# Main branch Source Control
resource "azurerm_app_service_source_control" "main" {
  branch = "main"
  app_id = azurerm_linux_web_app.main.id
  repo_url = var.remote_repo_url

  github_action_configuration {
    code_configuration {
      runtime_stack   = "python"
      runtime_version = "3.9"
    }
    generate_workflow_file = true
  }
}

# Staging branch Source Control
resource "azurerm_app_service_source_control_slot" "staging" {
  slot_id  = azurerm_linux_web_app_slot.main.id
  branch   = "staging"
  repo_url = var.remote_repo_url

  github_action_configuration {
    code_configuration {
      runtime_stack   = "python"
      runtime_version = "3.9"
    }
    generate_workflow_file = true
  }
}
```

**5. Create GitHub Token**

```hcl
# GitHub Token
resource "azurerm_source_control_token" "main" {
  type  = "GitHub"
  token = var.github_token
}
```

## Configuring Deployment Slots in Azure App Service

### Step-by-Step Guide

1. **Prerequisites**:

   - Azure subscription: If you don't have an Azure subscription, create a free account before you begin.
   - The app must be running in the Standard, Premium, or Isolated tier in order for you to enable multiple deployment slots.

2. **Add a Slot**:

   - In the Azure portal, navigate to your app's management page.
   - In the left pane, select Deployment slots > Add Slot.
   - If the app isn't already in the Standard, Premium, or Isolated tier, select Upgrade and go to the Scale tab of your app before continuing.
   - In the Add a slot dialog box, give the slot a name, and select whether to clone an app configuration from another deployment slot. Select Add to continue.

3. **Configure Deployment Slot**:

   - Each deployment slot is like a full-fledged App Service instance. The original App Service deployment slot is also called the production slot.
   - Deployment slots can copy the configuration (AppSettings and Connectionstrings) of the original App Service or other deployment slots.

4. **Swap Slots**:

   - You can validate app changes in a staging deployment slot before swapping it with the production slot.
   - Deploying an app to a slot first and swapping it into production makes sure that all instances of the slot are warmed up before being swapped into production.
   - The traffic redirection is seamless, and no requests are dropped because of swap operations.
   - You can automate this entire workflow by configuring auto swap when pre-swap validation isn't needed.
   - After a swap, the slot with previously staged app now has the previous production app. If the changes swapped into the production slot aren't as you expect, you can perform the same swap immediately to get your "last known good site" back.

5. **Limitations**:
   - Each App Service plan tier supports a different number of deployment slots.
   - To scale your app to a different tier, make sure that the target tier supports the number of slots your app already uses.

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
