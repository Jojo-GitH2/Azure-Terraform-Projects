## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.77.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.77.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_source_control.main](https://registry.terraform.io/providers/hashicorp/azurerm/3.77.0/docs/resources/app_service_source_control) | resource |
| [azurerm_application_gateway.main](https://registry.terraform.io/providers/hashicorp/azurerm/3.77.0/docs/resources/application_gateway) | resource |
| [azurerm_linux_web_app.main](https://registry.terraform.io/providers/hashicorp/azurerm/3.77.0/docs/resources/linux_web_app) | resource |
| [azurerm_public_ip.main](https://registry.terraform.io/providers/hashicorp/azurerm/3.77.0/docs/resources/public_ip) | resource |
| [azurerm_service_plan.main](https://registry.terraform.io/providers/hashicorp/azurerm/3.77.0/docs/resources/service_plan) | resource |
| [azurerm_source_control_token.main](https://registry.terraform.io/providers/hashicorp/azurerm/3.77.0/docs/resources/source_control_token) | resource |
| [azurerm_virtual_network.main](https://registry.terraform.io/providers/hashicorp/azurerm/3.77.0/docs/resources/virtual_network) | resource |
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/3.77.0/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_gateway"></a> [application\_gateway](#input\_application\_gateway) | Application Gateway Name | <pre>object({<br>    name = string<br>    sku = object({<br>      name = string<br>      tier = string<br>    })<br>    frontend_port = object({<br>      port = number<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | GitHub Token | `string` | n/a | yes |
| <a name="input_public_ip_name"></a> [public\_ip\_name](#input\_public\_ip\_name) | Public IP Name | `string` | n/a | yes |
| <a name="input_remote_repo_url"></a> [remote\_repo\_url](#input\_remote\_repo\_url) | n/a | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group Name | `string` | n/a | yes |
| <a name="input_service_plan_name"></a> [service\_plan\_name](#input\_service\_plan\_name) | Service Plan Name | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription ID | `string` | n/a | yes |
| <a name="input_virtual_network"></a> [virtual\_network](#input\_virtual\_network) | virtual network and subnets | <pre>object({<br>    name          = string<br>    address_space = list(string)<br>    subnets = list(object({<br>      name           = string<br>      address_prefix = string<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_web_app"></a> [web\_app](#input\_web\_app) | Web App | <pre>object({<br>    name = string<br>    site_config = object({<br>      ftps_state = string<br>      application_stack = object({<br>        python_version = string<br>      })<br>    })<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
