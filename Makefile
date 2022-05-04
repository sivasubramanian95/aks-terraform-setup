LOCATION ?= southeastasia
RESOURCE_GROUP ?= dev-api-backend-rg
AKS_CLUSTER_NAME ?= aks-cluster
ACR_NAME ?= kube3421
NODE_COUNT ?= 1
VM_SIZE ?= Standard_DS2_v2
KUBE_VERSION = 1.10.5
AKS_SP_FILE = $(HOME)/.azure/aksServicePrincipal.json
SUBSCRIPTION_ID ?= 
GRAFANA_POD_NAME=$(shell kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}')
JAEGER_POD_NAME=$(shell kubectl -n istio-system get pod -l app=jaeger -o jsonpath='{.items[0].metadata.name}')
APP_ID=$(shell az ad app list --query "[?displayName=='$(AKS_CLUSTER_NAME)'].{Id:appId}" --output table | tail -1)
AKS_PARAM =  --enable-addons http_application_routing 

.PHONY: create-cluster
create-cluster:
	#################################################################
	# Create AKS Cluster using terraform
	#################################################################
	terraform apply "main.tfplan"

PHONY: get-credential
get-credential:
	#################################################################
	# Get AKS Credentials
	#################################################################
	az aks get-credentials --resource-group $(RESOURCE_GROUP) --name $(AKS_CLUSTER_NAME)

.PHONY: get-node
get-node:
	kubectl get nodes

.PHONY: deploy-istio
deploy-istio:
	#################################################################
	# Deploy Istio in AKS Cluster
	#################################################################
	kubectl create ns istio-system
	kubectl apply -n istio-system -f ./istio/istio-aks.yaml
	kubectl label namespace default istio-injection=enabled

.PHONY: install-kiali
install-kiali:
	#################################################################
	# Install Kiali in AKS Cluster
	#################################################################
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/kiali.yaml

.PHONY: install-grafana
install-Grafana:
	#################################################################
	# Install Grafana in AKS Cluster
	#################################################################
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/grafana.yaml

.PHONY: install-jaeger
install-jaeger:
	#################################################################
	# Install Jaeger in AKS Cluster
	#################################################################
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/kiali.yaml