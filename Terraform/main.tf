provider "azurerm" {
    version = "~>2.0.0"
subscription_id = "a7bb6722-924d-4d98-8951-e3f968f22fbb"
client_id = "8e99cb42-05e4-4414-8e23-08a776ddd920"
client_secret = "4aQYPFNk.-.07b1g23Oy_gll~bboqt7YaS"
tenant_id = "f16a7c6c-ab1e-48d2-8680-b831066b896c"
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "Demo-ResourcesGroup-Terraform"
  location = "East US"
tags = {
  "environment" = "Terraform-Test"
    "Owner" = "Srimanta Ghosh"
}

}

resource "azurerm_virtual_network" "vnet" {
  name                = "Demo-network"
  address_space = [ "10.0.0.0/16" ]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "Snet" {
  name                 = "demo-snet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix = "10.0.1.0/24"
}

resource "azurerm_public_ip" "pip" {
  name                = "demo-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"

  
}

resource "azurerm_network_security_group" "nsg" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "RDP_Aloow"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }

  tags = {
    environment = "Terraform-Demo"
  }
}
resource "azurerm_subnet_network_security_group_association" "demo-sub-nsg-assoc" {
  subnet_id                 = azurerm_subnet.Snet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_interface_security_group_association" "demo-nic-nsg-assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
resource "azurerm_network_interface" "nic" {
  name                = "Demo-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name


  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.Snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}


resource "azurerm_windows_virtual_machine" "VM" {
  name                = "Demo-TF-VM"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_F2"
  admin_username      = "Administrator1"
  admin_password      = "Password@123"
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

