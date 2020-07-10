#!/usr/bin/env bash

# ENV
: "${GCP_SERVICE_ACCOUNT_KEY:?}"

echo "Authorizing with GCP..."
gcloud auth activate-service-account \
  --key-file=<(echo "${GCP_SERVICE_ACCOUNT_KEY}") \
  --project="cf-routing" 1>/dev/null 2>&1

echo "Deleting the Canary instance"
gcloud compute instances delete canary \
  --delete-disks=all \
  --project cf-routing \
  --zone us-central1-a \
  --quiet

echo "If you just saw a 'not found' error that's ok"

set -euo pipefail

echo "Creating Canary"
gcloud compute instances create canary \
  --machine-type n1-standard-8 \
  --project cf-routing \
  --zone us-central1-a \
  --image-family ubuntu-2004-lts --image-project ubuntu-os-cloud \
  --boot-disk-type pd-ssd \
  --boot-disk-size 250GB
