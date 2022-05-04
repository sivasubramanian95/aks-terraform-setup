output "client_certificate" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate
  sensitive = true
}
output "client_key" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.client_key
  sensitive = true
}
output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s.kube_config_raw
  sensitive = true
}
output "fqdn" {
  value = azurerm_kubernetes_cluster.k8s.fqdn
}
