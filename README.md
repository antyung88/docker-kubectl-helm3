# docker-kubectl-helm3 [![Release Github Packages](https://github.com/antyung88/docker-kubectl-helm3/actions/workflows/release.yml/badge.svg)](https://github.com/antyung88/docker-kubectl-helm3/actions/workflows/release.yml)
Container image with kubectl &amp; helm3 for CI/CD

This docker image contains Helm CLI and kubectl.

```
REPOSITORY                       TAG       IMAGE ID       CREATED         SIZE
ghcr.io/antyung88/kubectl-helm   latest    e06f7c6bfd58   1 minute ago    93.7MB
```

# Basic Usage Instructions

Execute kubectl
```
docker run ghcr.io/antyung88/kubectl-helm:latest kubectl
```

Execute helm
```
docker run ghcr.io/antyung88/kubectl-helm:latest helm3
```

# Alias Without Installation
Insert in ~/.bashrc or ~/.zshrc
```
alias kubectl='docker run ghcr.io/antyung88/kubectl-helm:latest kubectl'
alias helm3='docker run ghcr.io/antyung88/kubectl-helm:latest helm3'
```

# Quick Installation
Install kubectl & helm3
```
docker create -ti --name kubectl-helm ghcr.io/antyung88/kubectl-helm:latest bash && \
sudo docker cp kubectl-helm:/usr/bin/kubectl /usr/bin/kubectl && \
sudo docker cp kubectl-helm:/usr/bin/helm3 /usr/bin/helm3 && \
docker rm -f kubectl-helm
```

# GitLab Usage Instructions

- [Gitlab Agent Installed](https://gitlab.com/gitlab-org/charts/gitlab-agent)
- [Gitlab KAS Configured](https://docs.gitlab.com/ee/administration/clusters/kas.html)

```
kubectl:
  image: 
    name: ghcr.io/antyung88/kubectl-helm:latest
    entrypoint: ['']
  script:
    - kubectl config get-contexts
    - kubectl config use-context <repo_path>:<agent_name>
    # Basic Commands
    - kubectl get pods -A
    - helm3 list --all-namespaces
  when: manual
```
