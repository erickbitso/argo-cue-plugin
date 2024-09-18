#!/usr/bin/env bash

kind create cluster

kubectl apply -k https://github.com/argoproj/argo-cd/manifests/crds\?ref\=stable
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl create clusterrolebinding argocd-admin-binding \
  --clusterrole=cluster-admin \
  --serviceaccount=argocd:argocd-application-controller

docker build -t cue-plugin:latest .
kind load docker-image cue-plugin:latest

kubectl apply -f example/argocd-cm.yaml
kubectl -n argocd patch deployments/argocd-repo-server --patch-file example/argocd-repo-server-patch.yaml
sleep 20
echo -e "\033[35mPort forwarding ArgoCD\033[0m"
kubectl port-forward svc/argocd-server -n argocd 8080:443 >/dev/null 2>&1 &
sleep 5
# Login to ArgoCD
echo -e "\033[35mLogging in to ArgoCD\033[0m"
admin_password=$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d)
argocd login localhost:8080 --username admin --password $admin_password --insecure
# Change admin password to "password"
echo -e "\033[35mChanging admin password to 'password'\033[0m"
argocd account update-password --current-password $admin_password --new-password password

echo -e "\033[35mOpening browser to ArgoCD UI. User: admin, Password: password\033[0m"
open http://localhost:8080


