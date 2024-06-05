variable "resource_group_name" {}

variable "storage_account_name" {}

variable "azurerm_storage_container" {}

variable "azurerm_virtual_network" {}

variable "public_ip_address_id" {}

variable "subnet" {}

variable "network_interface_ids" {}

variable "azurerm_virtual_machine" {}

variable "cyclecloud_username" {
  description = "The username for the initial CycleCloud Admin user and VM user"
  #   type        = string
  #  default = ""
}
variable "cyclecloud_password" {
  description = "The initial password for the CycleCloud Admin user"
  #   type        = string
  #  default = ""
}

variable "cyclecloud_user_publickey" {
  description = "The public key for the initial CycleCloud Admin user and VM user"
  # type        = string
  #default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYwIl6MgbYGKegWJBZppXidAuH2/9EG0x/fxEJa2AEIqCT4rm/ibsdkiVATvL+UfxuMWnZ9Dyj9Zet70/UeeciDAj2GAZhsquyxO7pHSdEC6zhVQeRAfDHTrIVLBDWENf8VI4EU8MjFjf9ykWAStdDfL32VA41PAJA9f6YgqoKuiFXsHvlS9EyOcjcjnHyimwOXYh/oLu7k9uRB8yWiCYXJGp1DUr71urUR2uQy1FCC6M1H4z2ofDlcGOVkClhnImW0nDJ2Bf6YP0jVcQ6lmJsmAROxYdoQhvdP+4D4NBKuETm40hz3dmUmhhFTL4XErvrYZlLzITtuH9I6EP1wKuN rsa-key-20240604"
}


# Storage account name can contain only lowercase letters and numbers.
variable "cyclecloud_storage_account" {
  description = "Name of storage account to use for Azure CycleCloud storage locker"
  # default = "cctfstorage"
  #   type        = string
}

variable "cyclecloud_tenant_id" {
  description = "Service Principle Tenant ID"
 
}

variable "cyclecloud_application_id" {
  description = "Service Principle Application ID"

}

variable "cyclecloud_application_secret" {
  description = "Service Principle Application Secret"

}

variable "nsgrules" {

}
