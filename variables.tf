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
  default = ""
}
variable "client_id" {
  default = ""
}
variable "client_secret" {
  default = ""
}
variable "tenant_id" {
  default = ""
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
