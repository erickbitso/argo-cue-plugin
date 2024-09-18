FROM alpine:latest

# Install git and any necessary dependencies
RUN apk update && \
    apk add --no-cache git wget tar && \
    wget https://github.com/cue-lang/cue/releases/download/v0.9.2/cue_v0.9.2_linux_amd64.tar.gz -O - | tar xz && \
    mv cue /usr/local/bin/cue && \
    chmod +x /usr/local/bin/cue

# Set non-root user (since your security context sets non-root user)
# RUN addgroup -g 999 nonroot && adduser -u 999 -G nonroot -D nonroot
# USER 999

# Default command
CMD ["/var/run/argocd/argocd-cmp-server"]
