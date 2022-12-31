# Virtual Network with address space
resource "azurerm_virtual_network" "vnet" {
  name                = "${local.resource_name_prefix}-${var.virtual_network.vnet["name"]}"
  location            = var.region
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.virtual_network.vnet["address_prefixes"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = local.common_tags
}

# Subnet1 creation 
resource "azurerm_subnet" "subnet1" {
  name                 = "${local.resource_name_prefix}-${var.subnet1["subnet_1"].name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet1["subnet_1"].address_prefixes
}

# Subnet2 creation 
resource "azurerm_subnet" "subnet2" {
  name                 = "${local.resource_name_prefix}-${var.subnet2["subnet_2"].name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet2["subnet_2"].address_prefixes
}

# Network Security Group Creation - web-tier
resource "azurerm_network_security_group" "nsg1" {
  name                = "${local.resource_name_prefix}-${var.subnet1["subnet_1"].name}-nsg"
  location            = var.region
  resource_group_name = azurerm_resource_group.rg.name
}

# Network Security Group Creation- app-tier
resource "azurerm_network_security_group" "nsg2" {
  name                = "${local.resource_name_prefix}-${var.subnet2["subnet_2"].name}-nsg"
  location            = var.region
  resource_group_name = azurerm_resource_group.rg.name
}

# Create network security rule - open port [80,443] for inbound traffic
resource "azurerm_network_security_rule" "nsg_1_rule" {
  name                       = each.value["name"]
  priority                   = each.value["priority"]
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = each.value["port"]
  source_address_prefix      = each.value["src_addr_pre"]
  destination_address_prefix = "*"

  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = "${local.resource_name_prefix}-${var.subnet1["subnet_1"].name}-nsg"

  depends_on = [
    azurerm_network_security_group.nsg1
  ]

  for_each = var.nsg_1
}

# Create network security rule - open port [80,443,8080] for inbound traffic
resource "azurerm_network_security_rule" "nsg_2_rule" {
  name                       = each.value["name"]
  priority                   = each.value["priority"]
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = each.value["port"]
  source_address_prefix      = each.value["src_addr_pre"]
  destination_address_prefix = "*"

  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = "${local.resource_name_prefix}-${var.subnet2["subnet_2"].name}-nsg"

  depends_on = [
    azurerm_network_security_group.nsg2
  ]

  for_each = var.nsg_2
}

# Associate NSG1 with Subnet1
resource "azurerm_subnet_network_security_group_association" "nsg1-to-subnet1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id

  depends_on = [
    azurerm_network_security_group.nsg1,
    azurerm_subnet.subnet1
  ]
}

# Associate NSG2 with Subnet2
resource "azurerm_subnet_network_security_group_association" "nsg2-to-subnet2" {
  subnet_id                 = azurerm_subnet.subnet2.id
  network_security_group_id = azurerm_network_security_group.nsg2.id

  depends_on = [
    azurerm_network_security_group.nsg2,
    azurerm_subnet.subnet2
  ]
}

