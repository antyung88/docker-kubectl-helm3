FROM debian:latest AS helm

ENV HELM_VERSION=3.9.3
ENV RELEASE_ROOT="https://get.helm.sh"
ENV RELEASE_FILE="helm-v${HELM_VERSION}-linux-amd64.tar.gz"

RUN apt-get update && apt-get install curl -y && \
    curl -L ${RELEASE_ROOT}/${RELEASE_FILE} | tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm

FROM scratch

ENV PATH="/usr/bin:${PATH}"

# BusyBox Static Binary
COPY --from=ghcr.io/antyung88/scratch-sh:stable /lib /lib
COPY --from=ghcr.io/antyung88/scratch-sh:stable /bin /bin

# KUBECTL HELM
COPY --from=helm /usr/bin/helm /usr/bin/helm
COPY --from=bitnami/kubectl:latest /opt/bitnami/kubectl/bin/kubectl /usr/bin/kubectl
