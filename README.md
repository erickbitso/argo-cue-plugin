
# ArgoCD with Cue plugin (PoC)

This is a PoC to test an ArgoCD (Cue) plugin that generates manifests based on a transformation and provided override files:
  - A github repository https://github.com/erickbitso/cue-service-catalog.git where the Cue transformations are hosted.
  - A github repository https://github.com/erickbitso/service-repo.git where the application overrides are hosted.

## How to run

Execute `./setup.sh`, this will create a Kind cluster and setup ArgoCD with the plugin (running as a sidecar). The plugin image installs cue and git packages.

Now apply the example ArgoCD Application
```
kubectl apply -f example/argocd-sample-app.yaml
```

This will use the Cue transforms defined in `cue-service-catalog` and combine it with the override file in `service-repo`, by running this command (this is just an example, as the override file is actually stored in a separate repo):
```
$ cue cmd -t entity=models -t overrideFile=./overrides/deployment-config.yaml generate
apiVersion: apps/v1
kind: Deployment
metadata:
  name: models
  labels:
    app: models
spec:
  replicas: 5
  selector:
    matchLabels:
      app: models
  template:
    metadata:
      labels:
        app: models
    spec:
      containers:
        - name: models
          image: nginx:1.14.2
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: models
spec:
  selector:
    app.kubernetes.io/name: models
  ports:
    - protocol: TCP
      port: 8080
      targetPort: http

```