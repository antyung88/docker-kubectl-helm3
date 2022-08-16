FROM alpine:latest AS builder

ENV HELM_VERSION=3.9.3
ENV RELEASE_ROOT="https://get.helm.sh"
ENV RELEASE_FILE="helm-v${HELM_VERSION}-linux-amd64.tar.gz"
ENV USER=scratchuser
ENV UID=10001

RUN adduser \    
    --disabled-password \    
    --gecos "" \    
    --home "/nonexistent" \    
    --shell "/sbin/nologin" \    
    --no-create-home \    
    --uid "${UID}" \    
    "${USER}"

RUN apk update && apk add --no-cache git ca-certificates && update-ca-certificates curl && \
    curl -L ${RELEASE_ROOT}/${RELEASE_FILE} | tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm

FROM scratch

ENV PATH="/bin:/usr/bin:${PATH}"

# BusyBox
COPY --from=ghcr.io/antyung88/scratch-sh:stable /lib /lib
COPY --from=ghcr.io/antyung88/scratch-sh:stable /bin /bin

# User
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group

# kubectl helm
COPY --from=builder /usr/bin/helm /usr/bin/helm3
COPY --from=bitnami/kubectl:latest /opt/bitnami/kubectl/bin/kubectl /usr/bin/kubectl

USER scratchuser:scratchuser
