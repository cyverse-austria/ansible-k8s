
# https://github.com/argoproj/argo-helm/blob/main/charts/argo-cd/Chart.yaml
# docker build -t mbwali/argocd-avp:v3.2.6 .
FROM quay.io/argoproj/argocd:v3.2.6

USER root

RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv curl

# Switch back to ArgoCD user
USER 999

# Verify that the package is accessible
# Create a virtual environment and install PyGithub
RUN python3 -m venv venv && \
    ./venv/bin/pip install --upgrade pip && \
    ./venv/bin/pip install PyGithub

# Add venv to PATH so python & pip use it by default
ENV PATH="/home/argocd/venv/bin:$PATH"
