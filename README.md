# aks-terraform-setup
# azure-aks

Spin up Azure Kubernetes Service (AKS) cluster and deploy apps.

## Create Cluster

In this quickstart, an AKS cluster is deployed using terraform

```bash
$ make create-cluster
```

## Deploy Istio

Istio: an open platform to connect, manage, and secure microservices. Istio provides an easy way to create a network of deployed services with load balancing, service-to-service authentication, monitoring, and more, __**without requiring any changes in service code**__.

```bash
$ make deploy-istio
```
