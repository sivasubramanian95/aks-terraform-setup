
.PHONY: create-cluster
create-cluster:
	#################################################################
	# Create AKS Cluster using terraform
	#################################################################
	terraform apply "main.tfplan"

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
	
