#!/bin/bash

set -exo pipefail

function verify(){
    local subscription_id=$(az account show -oyaml | yq '.id')
    if [ "$subscription_id" == "6e564d5e-0c84-4bd9-a83f-a0fc8d4b26b6" ]; then
        echo "Wrong subscription"
        exit 1
    fi
}

function terraform(){
    pushd cluster/
    terraform apply --auto-approve
    popd
}

function kube(){
    az aks get-credentials --resource-group grafana-poc --name aks-cluster --overwrite-existing
}

function install_argocd(){
    helm install argocd/argo-cd --repo https://artifacthub.io/packages/helm/argo/argo-cd -nargocd --generate-name
}

function install_charts(){
    kubectl create namespace grafana 2> /dev/null

    helm upgrade --install prometheus-stack prometheus-community/kube-prometheus-stack -f prometheus-stack-values.yaml
    helm upgrade --install mimir-distributed grafana/mimir-distributed -ngrafana --version "5.5.0-weekly.304" -f grafana-mimir-values.yaml
    helm upgrade --install grafana-dashboard grafana/grafana -ngrafana -f grafana-dashboard-values.yaml
    helm upgrade --install grafana-alloy grafana/alloy -ngrafana -f grafana-alloy-values.yaml
}

function main(){
    verify
    terraform
    kube
    install_argocd
    install_charts
}

main
