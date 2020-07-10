#!/bin/bash

# https://cloud.google.com/sdk/gcloud/reference/compute/instances/create
gcloud compute instances create canary \
  --machine-type n1-standard-8 \
  --project cf-routing \
  --zone us-central1-a \
  --image-family ubuntu-2004-lts --image-project ubuntu-os-cloud \
  --boot-disk-type pd-ssd \
  --boot-disk-size 250GB

gcloud beta compute ssh --zone "us-central1-a" "pivotal@canary" --project "cf-routing" \
  --command "bash <(curl -s https://raw.githubusercontent.com/cf-routing/devenv/develop/setup.sh)"

gcloud compute instances stop canary --zone us-central1-a

# https://cloud.google.com/compute/docs/images/create-delete-deprecate-private-images#gcloud
gcloud compute images create devenv \
  --source-disk canary \
  --source-disk-zone us-central1-a

gcloud compute instances start canary --zone us-central1-a
