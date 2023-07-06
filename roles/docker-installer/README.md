docker-installer
================

Responsible for installing and configuring the correct version of Docker.

This role does not detect if a version of Docker is already present on the
system, and it does not stop or start Docker.

## Requirements

The `geerlingguy.docker` role must be installed. It should be listed in the
top-level requirements.yml file.
