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

data "azurerm_storage_container" "main" {
  name                 = var.storage_account.containers[0].name
  storage_account_name = azurerm_storage_account.main.name
}

resource "azurerm_storage_blob" "website" {
  # Upload all files in the "web" folder  
  # to the "web" container in the storage account
  for_each = fileset("${path.module}/web", "**/*")

  name                   = each.key
  storage_account_name   = azurerm_storage_account.main.name
  storage_container_name = var.storage_account.containers[0].name
  type                   = "Block"
  #   content_type = "text/html"
  source = "${path.module}/web/${each.key}"

  # Set content type for each file so that it can render correctly in the browser

  content_type = lookup(
    {
      ".html" = "text/html"
      ".css"  = "text/css"
      ".js"   = "application/javascript"
    },
    format(".%s", element(split(".", each.key), length(split(".", each.key)) - 1)), "application/octet-stream"
  )
}