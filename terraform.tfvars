resource_group_name = {
  resource_group_name = "rg-cyclecloud-nonprod-ci-01"
  location            = "centralindia"

}

storage_account_name = {
  storage_account_name     = "storagetestnetweb1"
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

azurerm_storage_container = {
  container_name        = "test-blob-container"
  container_access_type = "container"
}

public_ip_address_id = {
  pip_name          = "pip-cyclecloud-nonprod-ci-01"
  allocation_method = "Static"
  sku               = "Standard"
}

azurerm_virtual_network = {
  vnet_name     = "vnet-cyclecloud-nonprod-ci-01"
  address_space = ["10.0.0.0/16"]
}

subnet = {
  subnet_name      = "subnet-cyclecloud-nonprod-ci-01"
  address_prefixes = ["10.0.1.0/24"]
}

network_interface_ids = {
  nic_name                      = "nic-cyclecloud-nonprod-ci-01"
  ip_config_name                = "nic01-cyclecloud-nonprod-ci-01"
  private_ip_address_allocation = "Dynamic"
}

azurerm_virtual_machine = {
  vm_name        = "vm-cyclecloud-nonprod-ci-01"
  vm_size        = "Standard_D2as_v4"
  admin_username = "hpcuser"
  admin_password = "hpcclu@12345"
  os_disk_name   = "vm-cyclecloud-nonprod-ci-01_OsDisk_1"
  data_disk_name = "vm-cyclecloud-nonprod-ci-01_lun_0_2"
  computer_name  = "vm-cyclecloud-nonprod-ci-01"
}

cyclecloud_username = "hpcuser"

cyclecloud_password = "hpcclu@12345"

cyclecloud_user_publickey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYwIl6MgbYGKegWJBZppXidAuH2/9EG0x/fxEJa2AEIqCT4rm/ibsdkiVATvL+UfxuMWnZ9Dyj9Zet70/UeeciDAj2GAZhsquyxO7pHSdEC6zhVQeRAfDHTrIVLBDWENf8VI4EU8MjFjf9ykWAStdDfL32VA41PAJA9f6YgqoKuiFXsHvlS9EyOcjcjnHyimwOXYh/oLu7k9uRB8yWiCYXJGp1DUr71urUR2uQy1FCC6M1H4z2ofDlcGOVkClhnImW0nDJ2Bf6YP0jVcQ6lmJsmAROxYdoQhvdP+4D4NBKuETm40hz3dmUmhhFTL4XErvrYZlLzITtuH9I6EP1wKuN rsa-key-20240604"


# Storage account name can contain only lowercase letters and numbers.
cyclecloud_storage_account = "cctfstorage"


# cyclecloud_tenant_id = "3117010e-6663-46b2-8297-fa40b76e2866"

# cyclecloud_application_id = "715364b1-0c6a-4132-b37f-2d2a553962df"

# cyclecloud_application_secret = "M3w8Q~przpsppYL1BCYmniZkYOuoshCpNJ-mZcVj"

nsgrules = {
  HTTPS = {
    name                       = "HTTPS"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  HTTP = {
    name                       = "HTTP"
    priority                   = 1020
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  SSH = {
    name                       = "SSH"
    priority                   = 1030
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}