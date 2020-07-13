# Workstation pipeline

![pipeline](https://imgur.com/oJ9dy2A.png)

This folder describes a pipeline (visible
[here](https://networking.ci.cf-app.com/teams/cf-k8s/pipelines/workstations))
that automatically creates/recreates workstation environments for the Cloud
Foundry App Connectivity Program.

It first creates a Canary VM and attempts to install devenv to it. If this
passes, it rolls all the other environments.

We roll environments weekly to discourage saving data to, playing favorites
with, or otherwise customizing workstations.

## Manually rolling a workstation

It should always be safe to re-run the job that created a given workstation, but
manually triggering `build-canary-vm` will call environments to roll so don't do
that.

When rolling a workstation, note that it will get the most recent devenv image,
not the most recent changes in github.

## Adding a new workstation to the pipeline

To add a new environment, simply copy an existing workstation job, change the
name in both places, and set the pipeline. The name scheme is animals.

## Manually creating a one-off worksatation

You can run `tasks/build_workstation.sh` to provision a one-off workstation. This 
is a real quick (under 2 minutes) way to get up and running, but keep in mind
they won't be updated or managed by the pipeline.

## Connecting to a workstation

Use the following command to connect to a workstation:
```
gcloud compute ssh --zone "us-central1-a"  --project "cf-routing" pivotal@$workstationname
```
