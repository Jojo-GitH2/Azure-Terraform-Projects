variable "virtual_machine" {
  description = "Virtual machine configurations"
  type = map(object({
    name           = string
    location       = string
    size           = string
    subnet_id      = string
    admin_username = string
    public_key     = string
    # admin_password = string
    os_disk = object({
      name                 = string
      caching              = string
      storage_account_type = string
      disk_size_gb         = number
    })
    # data_disks = list(object({
    #   name = string
    #   caching = string
    #   storage_account_type = string
    #   disk_size_gb = number
    #   lun = number
    # }))
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
}

variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string
}

variable "tags" {
  description = "tags to be applied to all resources"
  type        = map(string)
}

variable "enable_public_ip" {
  description = "Enable public IP address"
  type        = bool
  default     = false
}


variable "public_ip" {
  description = "Public IP address configurations"
  type = object({
    allocation_method = string
    sku               = string
    sku_tier          = string
  })
}