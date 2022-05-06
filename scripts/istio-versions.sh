#!/bin/zsh
# Triggers restart of pods with outdated Istio proxy (data plane)

newVersion=$(istioctl proxy-status | grep -i istio-ingressgateway | awk '{print $7}')
podList=($(istioctl proxy-status | grep -iv ${newVersion} | awk 'NR>1 {print $1}'))

for pod in $podList; do
    names=(${(s/./)pod})
    echo "restarting pod $names..."
    kubectl get pod/${names[1]} -n ${names[2]} --wait=false
done