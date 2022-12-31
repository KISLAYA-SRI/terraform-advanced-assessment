# Create a Public IP for VM
resource "azurerm_public_ip" "public_ip_vm" {
  name                = "${local.resource_name_prefix}-public-ip-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.region
  allocation_method   = "Dynamic"
}

# Create a NIC
resource "azurerm_network_interface" "nic" {
  name                = "${local.resource_name_prefix}-nic"
  location            = var.region
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_vm.id
  }
}

# Create a linux virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${local.resource_name_prefix}-${var.vm["vm1"].name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.region
  size                = var.vm["vm1"].size
  admin_username      = var.vm["vm1"].admin_username

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  disable_password_authentication = false
  admin_password                  = var.vm["vm1"].password

  # delete_data_disks_on_termination = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

}

