#!/usr/bin/env bash

set -euo pipefail

# ENV
: "${GCP_SERVICE_ACCOUNT_KEY:?}"

echo "Authorizing with GCP..."
gcloud auth activate-service-account --key-file=<(echo "${GCP_SERVICE_ACCOUNT_KEY}") --project="${GCP_PROJECT}" 1>/dev/null 2>&1

echo "Installing devenv..."
gcloud beta compute ssh --zone "us-central1-a" "pivotal@canary" --project "cf-routing" \
  --command "bash <(curl -s https://raw.githubusercontent.com/cf-routing/devenv/develop/setup.sh)"
