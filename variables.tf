variable "region" {
  default = "East US"
}

variable "business_division" {
  type    = string
  default = "tf"
}

variable "environment" {
  type    = string
  default = "assessment"
}

variable "resource_group_name" {
  type    = string
  default = "rg"
}

variable "virtual_network" {
  type = map(any)
  default = {
    vnet = {
      name             = "vnet"
      address_prefixes = ["10.0.0.0/16"]
    }
  }
}

variable "subnet1" {
  type = map(any)
  default = {
    subnet_1 = {
      name             = "web-tier"
      address_prefixes = ["10.0.1.0/24"]
    }
  }
}

variable "subnet2" {
  type = map(any)
  default = {
    subnet_2 = {
      name             = "app-tier"
      address_prefixes = ["10.0.2.0/24"]
    }
  }
}

variable "nsg_1" {
  type = map(any)
  default = {
    rule_1 = {
      name     = "http-port"
      priority = "310"
      port     = "80"
      src_addr_pre = "14.102.43.0/24"
    }
    rule_2 = {
      name     = "https-port"
      priority = "320"
      port     = "443"
      src_addr_pre = "14.102.43.0/24"
    }
  }
}

variable "nsg_2" {
  type = map(any)
  default = {
    rule_1 = {
      name     = "http-port"
      priority = "310"
      port     = "80"
      src_addr_pre = "14.102.43.0/24"
    }
    rule_2 = {
      name     = "https-port"
      priority = "320"
      port     = "443"
      src_addr_pre = "14.102.43.0/24"
    }
    rule_3 = {
      name     = "port-8080"
      priority = "330"
      port     = "8080"
      src_addr_pre = "14.102.43.0/24"
    }
    rule_4 = {
      name     = "ssh"
      priority = "340"
      port     = "22"
      src_addr_pre = "14.102.43.0/24"
    }
  }
}

variable "vm" {
  type = map(any)
  default = {
    "vm1" = {
      name           = "vm"
      size           = "Standard_B1s"
      admin_username = "kislaya"
      password       = "Admin@123456"

    }
  }
}

variable "bastion-subnet" {
  type = map(any)
  default = {
    bastion = {
      name             = "AzureBastionSubnet"
      address_prefixes = ["10.0.3.0/26"]
    }
  }
}