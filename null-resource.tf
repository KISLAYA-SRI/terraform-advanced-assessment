# Null resource using file provisioner to transfer script.sh to the VM and remote-exec to run the script
resource "null_resource" "configure_vm" {
  triggers = {
    id = azurerm_linux_virtual_machine.vm.id
  }

  provisioner "file" {

    connection {
      type     = "ssh"
      user     = var.vm["vm1"].admin_username
      password = var.vm["vm1"].password
      host     = azurerm_public_ip.public_ip_vm.ip_address
    }
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = var.vm["vm1"].admin_username
      password = var.vm["vm1"].password
      host     = azurerm_public_ip.public_ip_vm.ip_address
    }

    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh"
    ]
  }

  depends_on = [azurerm_linux_virtual_machine.vm]
}