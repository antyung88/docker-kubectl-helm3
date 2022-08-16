# docker-kubectl-helm3
Container image with kubectl &amp; helm3 for CI/CD

This docker image contains Helm CLI and kubectl.

# Basic Usage Instructions

Execute kubectl
```
docker run ghcr.io/antyung88/kubectl-helm:latest kubectl
```

Execute helm
```
docker run ghcr.io/antyung88/kubectl-helm:latest helm3
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
