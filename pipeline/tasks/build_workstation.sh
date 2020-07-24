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

domain="${WORKSTATION_NAME}.ws.routing.lol"
external_static_ip=$(gcloud compute instances list | grep ${WORKSTATION_NAME} | awk '{print $5}')

echo "Configuring DNS for external IP: ${external_static_ip}"
gcloud dns record-sets transaction start --project cf-routing --zone="routing-lol"
gcp_records_json="$( gcloud dns record-sets list --project cf-routing --zone "routing-lol" --name "${domain}" --format=json )"
record_count="$( echo "${gcp_records_json}" | jq 'length' )"
if [ "${record_count}" != "0" ]; then
  existing_record_ip="$( echo "${gcp_records_json}" | jq -r '.[0].rrdatas | join(" ")' )"
  gcloud dns record-sets transaction remove --project cf-routing --name "${domain}" --type=A --zone="routing-lol" --ttl=300 "${existing_record_ip}" --verbosity=debug
fi
gcloud dns record-sets transaction add --project cf-routing --name "${domain}" --type=A --zone="routing-lol" --ttl=300 "${external_static_ip}" --verbosity=debug

echo "Contents of transaction.yaml:"
cat transaction.yaml
gcloud dns record-sets transaction execute --project cf-routing --zone="routing-lol" --verbosity=debug
