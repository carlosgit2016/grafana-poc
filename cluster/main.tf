provider "azurerm" {
    subscription_id = "6e564d5e-0c84-4bd9-a83f-a0fc8d4b26b6" 
    resource_provider_registrations = "none"
    features {}
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "grafana-poc"
  location = "eastus2"
}

resource "azurerm_container_registry" "acr" {
  name                     = "aksacr${random_string.acr_suffix.result}" # Replace with a globally unique name
  resource_group_name      = azurerm_resource_group.aks_rg.name
  location                 = azurerm_resource_group.aks_rg.location
  sku                      = "Basic"
  admin_enabled            = true
}

resource "random_string" "acr_suffix" {
  length  = 5
  upper   = false
  special = false
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "cflorcluster"

  default_node_pool {
    name            = "agentpool"
    node_count      = 1
    vm_size         = "Standard_B2s"
    min_count       = 1
    max_count       = 5
    auto_scaling_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.30.0"

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_plugin_mode = "overlay"
    outbound_type = "loadBalancer"
  }

  tags = {
    purpose = "grafana-poc"
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive = true
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}
