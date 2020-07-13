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

## Contributing

Please commit small improvements directly to `develop`.

If you a want others to weigh in first, open a pull request.

Goals:

* One devenv for the whole networking program \
  We want it to be easy to rotate among teams within the program. Having a
  common development environment should reduce friction when rotating or
  handling interrupts.
* Dev machines as cattle, not pets \
  We want it to be easy to create a new environment, and easy to let go of
  existing ones.

Non-goals:

* Idempotency \
  We don't care if the setup scripts are idempotent because we are prioritizing
  making it easy to throw away machines and create new ones.
* Supporting users outside of the Networking Program \
  We don't want to get bogged down over engineering this thing oand trying to
  meet everyone's needs. If other teams in the larger CF community find this
  userful, they can fork it.
