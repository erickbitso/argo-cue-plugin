FROM alpine:latest

# Install git and any necessary dependencies
RUN apk update && \
    apk add --no-cache git wget tar && \
    wget https://github.com/cue-lang/cue/releases/download/v0.9.2/cue_v0.9.2_linux_amd64.tar.gz -O - | tar xz && \
    mv cue /usr/local/bin/cue && \
    chmod +x /usr/local/bin/cue

# Default command
CMD ["/var/run/argocd/argocd-cmp-server"]
