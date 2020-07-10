#!/bin/bash

gcloud compute instances create dingo \
  --machine-type n1-standard-8 \
  --project cf-routing \
  --zone us-central1-a \
  --image devenv --image-project cf-routing \
  --boot-disk-type pd-ssd \
  --boot-disk-size 250GB

