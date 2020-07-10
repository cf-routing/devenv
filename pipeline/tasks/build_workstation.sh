#!/usr/bin/env bash

# ENV
: "${GCP_SERVICE_ACCOUNT_KEY:?}"
: "${WORKSTATION_NAME:?}"

echo "Authorizing with GCP..."
gcloud auth activate-service-account \
  --key-file=<(echo "${GCP_SERVICE_ACCOUNT_KEY}") \
  --project="cf-routing" 1>/dev/null 2>&1

echo "Deleting ${WORKSTATION_NAME}"
gcloud compute instances delete ${WORKSTATION_NAME} \
  --delete-disks=all \
  --project cf-routing \
  --zone us-central1-a \
  --quiet

echo "If you just saw a 'not found' error that's ok"

set -euo pipefail

echo "Creating ${WORKSTATION_NAME}"
gcloud compute instances create ${WORKSTATION_NAME} \
  --machine-type n1-standard-8 \
  --project cf-routing \
  --zone us-central1-a \
  --image devenv --image-project cf-routing \
  --boot-disk-type pd-ssd \
  --boot-disk-size 250GB
