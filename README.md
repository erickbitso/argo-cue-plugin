
# ArgoCD with Cue plugin (PoC)

This is a PoC to test an ArgoCD (Cue) plugin that generates manifests based on a transformation and provided override files:
  - A github repository https://github.com/erickbitso/cue-service-catalog.git where the Cue transformations are hosted.
  - A github repository https://github.com/erickbitso/service-repo.git where the application overrides are hosted.

## How to run

Execute `./setup.sh`, this will create a Kind cluster and setup ArgoCD with the plugin (running as a sidecar). The plugin image
installs cue and git packages.
