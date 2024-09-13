
# Install

```
kubectl create namespace argocd
kustomize build examples/plugins/helm/ | kubectl apply -n argocd -f -
```
