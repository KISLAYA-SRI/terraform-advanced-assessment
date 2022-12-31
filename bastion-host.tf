# Create a Public IP for Bastion Host
resource "azurerm_public_ip" "public_ip_bastion" {
  name                = "${local.resource_name_prefix}-public-ip_bastion"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.region

  allocation_method = "Static"
  sku               = "Standard"
}

# Subnet creation 
resource "azurerm_subnet" "bastion_subnet" {
  name                 = var.bastion-subnet["bastion"].name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.bastion-subnet["bastion"].address_prefixes
}

# Bastion Host
resource "azurerm_bastion_host" "bastion_host" {
  name                = "${local.resource_name_prefix}-${random_string.rs_name.id}-bastion-host"
  location            = var.region
  resource_group_name = azurerm_resource_group.rg.name

  copy_paste_enabled = true
  sku                = "Basic"

  ip_configuration {
    name                 = "ip-conf"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.public_ip_bastion.id
  }

}
