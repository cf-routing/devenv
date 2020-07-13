# devenv

A set of scripts for configuring a ubuntu machine (or docker image) for development of Cloud Foundry stuff.

## Installation

Provision your Ubuntu 20.04 VM, ssh into it, then run this command from your
home directory as a non-root user:

```
bash <(curl -s https://raw.githubusercontent.com/cf-routing/devenv/develop/setup.sh)
```

Note that this script is not guaranteed to be idempotent. Rather than re-running the scripts, it is recommended that you recreate your workstation VMs regularly to keep up to date.

## Automated workstation provisioning

A set of [Concourse pipelines](pipeline/README.md) are also maintained in this
repository for automated workstation provisioning.
