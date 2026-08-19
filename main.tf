resource "azurerm_resource_group" "rgs" {
  name = "satyam-rg"
  location = "EAST US"
}

resource "azurerm_kubernetes_cluster" "dev-aks" {
  name                = "dev-aks1"
  location            = azurerm_resource_group.rgs.location
  resource_group_name = azurerm_resource_group.rgs.name
  dns_prefix          = "dev-aks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v7"
  }
   node_provisioning_profile {
    mode              = "Auto"             # Enables automatic node management
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "dev"
  }
}