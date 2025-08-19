provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "aksfree"

  default_node_pool {
    name       = "default"
    vm_size    = var.vm_size      # Free-tier eligible size
    node_count = var.node_count   # Keep to 1 for free tier
    os_disk_size_gb = 30          # Optional: Keep disk size minimal
    type       = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  
  network_profile {
    network_plugin = "kubenet" # Simpler and cheaper than Azure CNI
  }

  tags = {
    environment = var.environment
    costcenter  = "free-tier"
  }
}