variable "resourcename" {
  default = "k8s-resources"
}
variable "clustername" {
  default = "kubernetes-aks1"
}
variable "location" {
  default = "West Europe"
}
variable "dnspreffix" {
  default = "kubecluster"
}
variable "size" {
  default = "Standard_D2_v2"
}
variable "agentnode" {
  default = "1"
}
variable "subscription_id" {
  default = "45142e4c-1813-496e-9b55-c92dd9dbf2d4"
}
variable "client_id" {
  default = "52ded899-47de-4ff7-b0ca-6dd208752478"
}
variable "client_secret" {
  default = "M37Y8hY~aZef4.zfhX5NDVIXxhI3taXesg"
}
variable "tenant_id" {
  default = "f6dfcc78-c8ef-4d40-9c41-b57c69fd3ab1"
}

##ISTIO variables

variable "istio_namespace" {
  default = "istio-system"
}
variable "grafana" {
  default = "grafana"
}
variable "kiali" {
  default = "kiali"
}