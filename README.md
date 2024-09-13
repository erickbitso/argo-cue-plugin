
# Install

```
kubectl apply -k https://github.com/argoproj/argo-cd/manifests/crds\?ref\=stable
kubectl create namespace argocd
kustomize build examples/plugins/helm/ | kubectl apply -n argocd -f -
```
