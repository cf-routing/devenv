# workstation pipeline

![pipeline](https://imgur.com/oJ9dy2A.png)

This folder describes a pipeline (visible
[here](https://networking.ci.cf-app.com/teams/cf-k8s/pipelines/workstations))
that automatically creates/recreates workstation environments for the Cloud
Foundry App Connectivity Program.

It first creates a Canary VM and attempts to install devenv to it. If this
passes, it rolls all the other environments.

We roll environments weekly to discourage saving data to, playing favorites
with, or otherwise customizing workstations.

## manually rolling a workstation

It should always be safe to re-run the job that created a given workstation, but
manually triggering `build-canary-vm` will call environments to roll so don't do
that.

When rolling a workstation, note that it will get the most recent devenv image,
not the most recent changes in github.

## adding a new workstation

To add a new environment, simply copy an existing workstation job, change the
name in both places, and set the pipeline. The name scheme is animals.
