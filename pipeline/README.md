# Workstation pipeline

This folder describes a pipeline (visible
[here](https://networking.ci.cf-app.com/teams/cf-k8s/pipelines/workstations))
that automatically creates/recreates workstation environments for the Cloud
Foundry App Connectivity Program.

It builds a new base image every time a new commit is pushed to devenv. Then on
saturday nights, all the workstations roll getting the new image.

## Manually rolling a workstation

At any time, you can trigger your workstation's job in the pipeline to get the
latest changes from devenv. It takes under a minute, but keep in mind any
changes on that machine will be lost.

## Adding a new workstation to the pipeline

To add a new environment, simply copy an existing workstation job, change the
name in both places, and set the pipeline. The name scheme is animals.

## Manually creating a one-off worksatation

1. Navigate to the compute instances page in the GCP console
1. Select an existing workstation and select "Create Similar" at the top
1. Choose a name you like, make any other changes you need
   * _Note:_ Make sure the boot disk image is `devenv` from the cf-routing
     project
1. Hit create!

## Connecting to a workstation

Use the following command to connect to a workstation:
```
gcloud compute ssh --zone "us-central1-a"  --project "cf-routing" pivotal@$workstationname
```
