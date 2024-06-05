
# creating a resource group
resource "azurerm_resource_group" "rg1" {
  name     = var.resource_group_name.resource_group_name
  location = var.resource_group_name.location
}

# creating a storage
resource "azurerm_storage_account" "storage-test" {
  depends_on               = [azurerm_resource_group.rg1]
  name                     = var.storage_account_name.storage_account_name
  resource_group_name      = var.resource_group_name.resource_group_name
  location                 = var.resource_group_name.location
  account_tier             = var.storage_account_name.account_tier
  account_replication_type = var.storage_account_name.account_replication_type
  network_rules {
    default_action = "Allow"
  }
  # static_website {
  #   index_document     = "index.html"
  #   error_404_document = "404.html"
  # }
}

# resource "azurerm_storage_container" "static-website" {
#   name                  = "$web"
#   storage_account_name  = azurerm_storage_account.storage-test.name
#   container_access_type = "blob"
# }

# resource "azurerm_storage_blob" "index_html" {
#   name                   = "index.html"
#   storage_account_name   = azurerm_storage_account.storage-test.name
#   storage_container_name = azurerm_storage_container.static-website.name
#   type                   = "Block"
#   source_content         = <<HTML
# <!DOCTYPE html>
# <html lang="en-us">

#     <head>
#         <base href="/">

#         <title>Azure CycleCloud</title>

#         <meta name="Copyright" content="Copyright &copy; Microsoft 2022">
#         <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

#         <link rel="stylesheet" href='static/dojo/resources/dojo.css?_v=8.6.1-3248' type="text/css">
#         <link rel="stylesheet" href='static/dijit/themes/tundra/tundra.css?_v=8.6.1-3248' type="text/css">
#         <link rel="stylesheet" href='static/pico/css/ms.css?_v=8.6.1-3248' type="text/css">
#         <link rel="stylesheet" href='static/pico/css/datatable.css?_v=8.6.1-3248' type="text/css">

#         <link rel="stylesheet" href='static/pico/css/ionicons.min.css?_v=8.6.1-3248' type="text/css">

#         <link rel="stylesheet" href='static/pico/css/menu.css?_v=8.6.1-3248' type="text/css">
#         <link rel="stylesheet" href='static/office-ui-fabric-react/css/fabric.css?_v=8.6.1-3248' type="text/css">
#         <link rel="stylesheet" href='static/pico/css/base_theme.css?_v=8.6.1-3248' type="text/css">

#         <link rel="icon" href='static/favicon.ico?_v=8.6.1-3248' type="image/x-icon">
#         <link rel="shortcut icon" href='static/favicon.ico?_v=8.6.1-3248' type="image/x-icon">
#     </head>

#     <body dir="ltr" class="ms-Fabric">
#         <div id="root"></div>
#         <script src='static/main.bundle.js?_v=8.6.1-3248'></script>
#         <script>
#             startApp();
#         </script>
#     </body>

# </html>
# HTML
# }

# # Optional: Additional blobs for CSS, JS, etc.
# # You can add more azurerm_storage_blob resources for each static file.

# output "static_website_url" {
#   value = azurerm_storage_account.storage-test.primary_web_endpoint
# }

# creating a container-blob storage
resource "azurerm_storage_container" "container" {
  depends_on            = [azurerm_storage_account.storage-test]
  name                  = var.azurerm_storage_container.container_name
  storage_account_name  = azurerm_storage_account.storage-test.name
  container_access_type = var.azurerm_storage_container.container_access_type
}

# creating a Public IP
resource "azurerm_public_ip" "pip" {
  depends_on          = [azurerm_resource_group.rg1]
  name                = var.public_ip_address_id.pip_name
  resource_group_name = var.resource_group_name.resource_group_name
  location            = var.resource_group_name.location
  allocation_method   = var.public_ip_address_id.allocation_method
  sku                 = var.public_ip_address_id.sku
}

# creating NSG
resource "azurerm_network_security_group" "nsg" {
  name                = "netweb-nsg"
  location            = var.resource_group_name.location
  resource_group_name = var.resource_group_name.resource_group_name

}

# creating NSG rules
resource "azurerm_network_security_rule" "nsg_rules" {
  depends_on                  = [azurerm_resource_group.rg1]
  for_each                    = var.nsgrules
  name                        = each.key
  direction                   = each.value.direction
  access                      = each.value.access
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# creating a Virtual Network
resource "azurerm_virtual_network" "vnet" {
  depends_on          = [azurerm_resource_group.rg1]
  name                = var.azurerm_virtual_network.vnet_name
  address_space       = var.azurerm_virtual_network.address_space
  location            = var.resource_group_name.location
  resource_group_name = var.resource_group_name.resource_group_name
}

# creating a subnet
resource "azurerm_subnet" "subnet" {
  depends_on           = [azurerm_virtual_network.vnet]
  name                 = var.subnet.subnet_name
  resource_group_name  = var.resource_group_name.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet.address_prefixes
}


# creating a Network Interface
resource "azurerm_network_interface" "nic" {
  depends_on          = [azurerm_subnet.subnet]
  name                = var.network_interface_ids.nic_name
  location            = var.resource_group_name.location
  resource_group_name = var.resource_group_name.resource_group_name

# adding private IP and Public IP to VM
  ip_configuration {
    name                          = var.network_interface_ids.ip_config_name
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = var.network_interface_ids.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}



# creating a CycleCloud VM
resource "azurerm_virtual_machine" "example" {
  name                  = var.azurerm_virtual_machine.vm_name
  location              = var.resource_group_name.location
  resource_group_name   = var.resource_group_name.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = var.azurerm_virtual_machine.vm_size

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = false

  storage_os_disk {
    name              = var.azurerm_virtual_machine.os_disk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "StandardSSD_LRS"
    disk_size_gb      = 30
  }

  storage_data_disk {
    name              = var.azurerm_virtual_machine.data_disk_name
    lun               = 0
    caching           = "None"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 512
  }

  storage_image_reference {
    publisher = "azurecyclecloud"
    offer     = "azure-cyclecloud"
    sku       = "cyclecloud8-gen2"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.azurerm_virtual_machine.computer_name
    admin_username = "azureadmin"
    admin_password = "admin@123456"
  }

  os_profile_linux_config {
    disable_password_authentication = false
    # ssh_keys = []
  }

  plan {
    name      = "cyclecloud8-gen2"
    publisher = "azurecyclecloud"
    product   = "azure-cyclecloud"
  }

  #   boot_diagnostics {
  #     enabled = true
  #   }
}

# data "azurerm_subscription" "current" {}

# data "azurerm_role_definition" "contributor" {
#     name  = "Contributor"
#     scope = "${data.azurerm_subscription.current.id}"
# }

# resource "azurerm_role_assignment" "role" {
#   scope                = data.azurerm_subscription.current.id
#   role_definition_id   = data.azurerm_role_definition.contributor.id
#   principal_id         = azurerm_linux_virtual_machine.vm.identity[0].principal_id
# }

# resource "azurerm_virtual_machine_extension" "install_cyclecloud" {
#   name                 = "CustomScriptExtension"
#   virtual_machine_id   = azurerm_linux_virtual_machine.vm.id
#   publisher            = "Microsoft.Azure.Extensions"
#   type                 = "CustomScript"
#   type_handler_version = "2.0"
#   depends_on           = [azurerm_linux_virtual_machine.vm]

#     # ${var.cyclecloud_dns_label}.${var.location}.cloudapp.azure.com" 
#   settings = <<SETTINGS
#     {
#          "commandToExecute": "echo \"Launch Time: \" > /tmp/launch_time  && date >> /tmp/launch_time && curl -k -L -o /tmp/cyclecloud_install.py \"${local.cyclecloud_install_script_url}\" && python3 /tmp/cyclecloud_install.py --acceptTerms --useManagedIdentity --username=${var.cyclecloud_username} --password='${var.cyclecloud_password}' --publickey='${var.cyclecloud_user_publickey}' --storageAccount=${var.cyclecloud_storage_account} --webServerMaxHeapSize=4096M --webServerPort=80 --webServerSslPort=443"
#     }
# SETTINGS
# }

