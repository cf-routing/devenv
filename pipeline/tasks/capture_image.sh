#!/usr/bin/env bash

set -euo pipefail

# ENV
: "${GCP_SERVICE_ACCOUNT_KEY:?}"

echo "Authorizing with GCP..."
gcloud auth activate-service-account \
  --key-file=<(echo "${GCP_SERVICE_ACCOUNT_KEY}") \
  --project="cf-routing" 1>/dev/null 2>&1


echo "Stopping Canary..."
gcloud compute instances stop canary --zone us-central1-a

echo "Deleting the old image"
gcloud compute images create devenv --quiet

echo "Capturing image..."
# https://cloud.google.com/compute/docs/images/create-delete-deprecate-private-images#gcloud
gcloud compute images create devenv \
  --source-disk canary \
  --source-disk-zone us-central1-a

echo "Starting canary back up..."
gcloud compute instances start canary --zone us-central1-a
