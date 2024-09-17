
# Install

```
kubectl apply -k https://github.com/argoproj/argo-cd/manifests/crds\?ref\=stable
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl create clusterrolebinding argocd-admin-binding \
  --clusterrole=cluster-admin \
  --serviceaccount=argocd:argocd-application-controller
kubectl apply -f example/argocd-cm.yaml
kubectl -n argocd patch deployments/argocd-repo-server --patch-file example/argocd-repo-server-patch.yaml
```
