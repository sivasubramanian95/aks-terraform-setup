RESOURCE_GROUP ?= k8s-resources
AKS_CLUSTER_NAME ?= kubernetes-aks1

# GRAFANA_POD_NAME=$(shell kubectl -n istio-system get pod -l app=grafana -o jsonpath='{.items[0].metadata.name}')
# JAEGER_POD_NAME=$(shell kubectl -n istio-system get pod -l app=jaeger -o jsonpath='{.items[0].metadata.name}')
# APP_ID=$(shell az ad app list --query "[?displayName=='$(AKS_CLUSTER_NAME)'].{Id:appId}" --output table | tail -1)

.PHONY: create-plan
create-plan:
	#################################################################
	# Create terraform plan
	#################################################################
	terraform plan --out "main.tfplan"

.PHONY: create-cluster
create-cluster:
	#################################################################
	# Create AKS Cluster using terraform
	#################################################################
	terraform apply "main.tfplan"

.PHONY: get-credential
get-credential:
	################################################################
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
	istioctl install --set profile=demo
	#kubectl apply -n istio-system -f /Users/sivasubramanian/WORK_DIR/AKS/aks-terraform-setup/.istio/istio-aks.yaml
	kubectl label namespace default istio-injection=enabled

.PHONY: install-prometheus
install-prometheus:
	#################################################################
	# Install Prometheus in AKS Cluster
	#################################################################
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.13/samples/addons/prometheus.yaml

.PHONY: install-kiali
install-kiali:
	#################################################################
	# Install Kiali in AKS Cluster
	#################################################################
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/kiali.yaml

.PHONY: install-grafana
install-grafana:
	#################################################################
	# Install Grafana in AKS Cluster
	#################################################################
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/grafana.yaml

.PHONY: install-jaeger
install-jaeger:
	#################################################################
	# Install Jaeger in AKS Cluster
	#################################################################
	kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.7/samples/addons/jaeger.yaml
	
.PHONY: deploy-app
deploy-app:
	#################################################################
	# Deploy BOOKINFO app in AKS Cluster
	#################################################################
	kubectl apply -f /Users/sivasubramanian/WORK_DIR/AKS/aks-terraform-setup/samples/bookinfo/platform/kube/bookinfo.yaml

PHONY: deploy-app-gw
deploy-app-gw:
	#################################################################
	# Deploy BOOKINFO app gateway in AKS Cluster
	#################################################################
	kubectl apply -f /Users/sivasubramanian/WORK_DIR/AKS/aks-terraform-setup/samples/bookinfo/networking/bookinfo-gateway.yaml
	kubectl apply -f /Users/sivasubramanian/WORK_DIR/AKS/aks-terraform-setup/samples/bookinfo/networking/destination-rule-all.yaml
