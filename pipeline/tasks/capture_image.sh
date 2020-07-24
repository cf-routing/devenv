#!/usr/bin/env bash

set -euo pipefail

# ENV
: "${GCP_SERVICE_ACCOUNT_KEY:?}"
: "${MACHINE_NAME:?}"

echo "Authorizing with GCP..."
gcloud auth activate-service-account \
  --key-file=<(echo "${GCP_SERVICE_ACCOUNT_KEY}") \
  --project="cf-routing" 1>/dev/null 2>&1


echo "Stopping ${MACHINE_NAME}..."
gcloud compute instances stop ${MACHINE_NAME} --zone us-central1-a

echo "Deleting the old image"
gcloud compute images delete devenv --quiet

echo "Capturing image..."
# https://cloud.google.com/compute/docs/images/create-delete-deprecate-private-images#gcloud
gcloud compute images create devenv \
  --source-disk ${MACHINE_NAME} \
  --source-disk-zone us-central1-a

echo "Deleting ${MACHINE_NAME} instance..."
gcloud compute instances delete ${MACHINE_NAME} \
  --delete-disks=all \
  --project cf-routing \
  --zone us-central1-a \
  --quiet
