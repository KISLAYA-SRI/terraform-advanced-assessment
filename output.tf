output "vnet-name" {
  value = azurerm_virtual_network.vnet.name
}

output "nsg1-name" {
  value = azurerm_network_security_group.nsg1.name
}

output "nsg2-name" {
  value = azurerm_network_security_group.nsg2.name
}

output "vm-public-ip" {
  value = azurerm_public_ip.public_ip_vm.ip_address
}

output "instance-id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "instance-username" {
  value = azurerm_linux_virtual_machine.vm.admin_username
}

output "bastion-public-ip" {
  value = azurerm_public_ip.public_ip_bastion.ip_address
}

output "bastion-host-name" {
  value = azurerm_bastion_host.bastion_host.name
}