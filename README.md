
# Install

```
kubectl apply -k https://github.com/argoproj/argo-cd/manifests/crds\?ref\=stable
kubectl create namespace argocd
kustomize build examples/plugins/helm/ | kubectl apply -n argocd -f -
kubectl apply -f argocd-cm.yaml 
kubectl apply -f clusterrole.yaml

```
