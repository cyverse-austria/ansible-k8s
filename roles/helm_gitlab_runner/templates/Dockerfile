FROM alpine:latest

# Install required packages
RUN apk update && \
    apk add --no-cache \
    git \
    bash \
    curl \
    ca-certificates \
    openssh

# Create a user for GitLab Runner (with UID 1000)
RUN adduser -D -u 1000 gitlab-runner

# Set up the working directory
USER gitlab-runner
WORKDIR /home/gitlab-runner

# Set HOME for the user (if not automatically set)
ENV HOME=/home/gitlab-runner

# Ensure git config file exists (optional)
RUN touch /home/gitlab-runner/.gitconfig && \
    chown gitlab-runner:gitlab-runner /home/gitlab-runner/.gitconfig

# Make sure user can access home directory and .gitconfig
RUN chmod 755 /home/gitlab-runner && \
    chmod 644 /home/gitlab-runner/.gitconfig
