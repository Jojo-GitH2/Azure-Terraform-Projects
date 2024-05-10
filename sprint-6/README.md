[Home](../README.md) | [Sprint 1](README.md)

---

<p align="right">
    <img src="../.assets/logo-02.png" width="140x" />
</p>

# Knixat Cloud DevOps - Sprint 6

## Sprint Objective

- [Deploy a function app to Azure using terraform](../sprint-6/Function%20App/)
- [Deploy a Logic App to Azure using terraform](../sprint-6/Logic%20App/)

## Screenshots

- [Function App](../sprint-6/Function%20App/images/)
- [Logic App](../sprint-6/Logic%20App/files/images/)

## Deploy a Function App to Azure using terraform

In this guide, we will deploy an Azure Function written in Python using Terraform. The Azure Function generates an email address based on the provided first name and last name.

## Prerequisites

- An Azure subscription and an active Azure account.
- Visual Studio Code (VS Code) with the Azure Functions extension installed.
- Azure Storage Emulator or an Azure Storage Account for local testing.

## Step 1: Set Up Required Provider and Variables

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

variable "resource_group_name" {
  type        = string
  description = "Name of the Azure resource group where resources will be created."
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID where resources will be deployed."
}

# Define other variables (storage_account, service_plan, function_app) as well.
```

## Step 2: Create an Azure Resource Group

```hcl
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = "East US"  # Replace with your desired Azure region
}
```

## Step 3: Create an Azure Storage Account

```hcl
resource "azurerm_storage_account" "main" {
  name                     = var.storage_account.name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = var.storage_account.account_tier
  account_replication_type = var.storage_account.account_replication_type
}
```

## Step 4: Create an Azure Service Plan

```hcl
resource "azurerm_service_plan" "main" {
  name                = var.service_plan.name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = var.service_plan.os_type
  sku_name            = var.service_plan.sku_name
}
```

## Step 5: Create an Azure Function App

```hcl
resource "azurerm_linux_function_app" "main" {
  location            = azurerm_resource_group.main.location
  name                = var.function_app.name
  resource_group_name = azurerm_resource_group.main.name
  service_plan_id     = azurerm_service_plan.main.id

  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key

  site_config {
    application_stack {
      python_version = "3.9"
    }

  }
}
```

## Step 6: Deploy Your Function Code

You can deploy your Python Azure Function to the created Function App using Visual Studio Code (VS Code). The Python function code you want to deploy is as follows:

```python
import azure.functions as func
import logging
from datetime import datetime
import random
import string

app = func.FunctionApp(http_auth_level=func.AuthLevel.ANONYMOUS)

@app.route(route="http_trigger")
def http_trigger(req: func.HttpRequest) -> func.HttpResponse:
    logging.info("Python HTTP trigger function processed a request.")

    firstName = req.params.get("firstName")
    lastName = req.params.get("lastName")
    if not firstName and not lastName:
        try:
            req_body = req.get_json()
        except ValueError:
            pass

    if firstName and lastName:
        random_string = "".join(
            random.choice(string.ascii_letters + string.digits) for _ in range(4)
        )
        return func.HttpResponse(
            "Generated Email Address: " + f"{firstName}.{lastName}.{random_string}@cloud.knixat.com".lower()
        )
    elif firstName or lastName:
        return func.HttpResponse(
            "Please provide both first name and last name for a personalized response. To test this function, try the following URL: https://<function_app_name>.azurewebsites.net/api/http_trigger?firstName=John&lastName=Doe ",
            status_code=400,
        )
    else:
        return func.HttpResponse(
            "This HTTP triggered function executed successfully. Pass your first name and last name in the query string or in the request body for a personalized response. To test this function, try the following URL: https://<function_app_name>.azurewebsites.net/api/http_trigger?firstName=John&lastName=Doe",
            status_code=200,
        )

@app.schedule(arg_name="timer", schedule="*/2 * * * *")
def timer(timer: func.TimerRequest) -> None:
    present_time = datetime.now().astimezone().isoformat()

    if timer.past_due:
        logging.info("The timer is past due!")

    logging.info("Python timer trigger function ran at %s", present_time)
```

You can use the Azure Functions extension in Visual Studio Code to create a new function project, add your Python function code, and publish it to your Azure Function App.

To test your function on your local machine, make sure to do a debug run in Visual Studio Code to register the function under the local projects in the workspace. Additionally, you can use an Azure Storage Emulator or an Azure Storage Account for local testing.

## Step 7: Access Your Azure Function

You can access your Azure Function App through the Azure portal or by using the provided URL, which is typically found in the Terraform output or the Azure portal under the Function App's properties.

## Step 8: Clean Up (Optional)

If you no longer need the deployed resources, you can remove them using Terraform's `destroy` command:

```hcl
terraform destroy
```

## Deploy a Logic App to Azure using terraform

In this guide, we will deploy an Azure Logic App using Terraform. The Logic App sends an email to a specified email address when a new file is added to an Azure Storage Account.

## Prerequisites

- An Azure subscription and an active Azure account.

## Step 1: Set Up Required Provider and Variables

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

variable "resource_group_name" {
  type        = string
  description = "Name of the Azure resource group where resources will be created."
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID where resources will be deployed."
}

# Define other variables (storage_account, logic_app) as well.
```

## Step 2: Create an Azure Resource Group

```hcl
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = "East US"  # Replace with your desired Azure region
}
```

## Step 3: Create an Azure Storage Account

```hcl
resource "azurerm_storage_account" "main" {
  name                     = var.storage_account.name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = var.storage_account.account_tier
  account_replication_type = var.storage_account.account_replication_type
}
```

## Step 4: Create a Storage Container

```hcl
resource "azurerm_storage_container" "main" {
  name                  = var.storage_container.name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = var.storage_container.container_access_type
}
```

## Step 5: Create an Azure Logic App

```hcl
resource "azurerm_logic_app_workflow" "main" {
  name                = var.logic_app.name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}
```

## Step 6: Create a Logic App Trigger and Actions on Azure Portal

1. Navigate to the Azure portal and open your Logic App.
2. Click on the **Logic App Designer** tab.
3. Click on the **+ New Step** button.
4. Search for **Azure Blob Storage** and select the **When a blob is added or modified (properties only)** trigger.
5. Select Storage Account and Container.
6. Click on the **+ New Step** button.
7. Search for **HTTPWebhook** and select the **HTTP** action.
8. Select the **POST** method.
9. Type in a webhook uri and click on the **Save** button.
10. Go to the Storage Account and Container you selected in the trigger.
11. Upload a file to the container.
12. Go back to the Logic App and click on the **Run Trigger** button.
13. Click on the **Run** button.
14. Check your webhook site for the HTTP POST request.

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

```

```
