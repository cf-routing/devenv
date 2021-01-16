#!/bin/bash

target() {
  gobosh_target "${@}"
  cf_target "${@}"
}

gobosh_untarget() {
  unset BOSH_ENV
  unset BOSH_DIR
  unset BOSH_USER
  unset BOSH_PASSWORD
  unset BOSH_ENVIRONMENT
  unset BOSH_GW_HOST
  unset BOSH_GW_PRIVATE_KEY
  unset BOSH_CA_CERT
  unset BOSH_DEPLOYMENT
  unset BOSH_CLIENT
  unset BOSH_CLIENT_SECRET
}

gobosh_target() {
  gobosh_untarget
  if [ $# = 0 ]; then
    return
  fi

  export BOSH_ENV=$1
  export BOSH_DIR="$(lookup_env $BOSH_ENV)"

  changes="$(git -C ${BOSH_DIR} status --porcelain)"
  exit_code="${?}"
  if [[ "${exit_code}" -eq 0 ]] && [[ -z "${changes}" ]]; then
    git -C $BOSH_DIR pull
  fi

  pushd $BOSH_DIR 1>/dev/null
      eval "$(bbl print-env)"
  popd 1>/dev/null

  export BOSH_DEPLOYMENT="cf"
}

cf_target() {
  if [ $# = 0 ]; then
    echo "missing environment-name"
    echo ""
    echo "example usage:"
    echo "cft environment-name"
    return
  fi
  env=$1

  if [ "$env" = "ci" ]; then
    echo "no CF deployed in ci env."
    return
  fi

  if [ -f "${HOME}/workspace/networking-oss-deployments/environments/${1}/cats_integration_config.json" ]; then
    password=$(jq -r '.admin_password' < "${HOME}/workspace/networking-oss-deployments/environments/${1}/cats_integration_config.json")
  else
    password=$(credhub get -n "/bosh-${env}/cf/cf_admin_password" | bosh int --path /value -)
    uaa_password=$(credhub get -n "/bosh-${env}/cf/uaa_admin_client_secret" | bosh int --path /value -)
  fi

  [ -f "${HOME}/workspace/networking-oss-deployments/environments/${1}/cats_integration_config.json" ] && workspace="cf-k8s" || workspace="routing"

  if [ "$env" = "pickelhelm" ] || [ "$env" = "toque" ] || [ "$env" = "mitre" ] || [ "$env" = "caubeen" ]; then
    # we don't make c2c envs anymore. Everything else should use the routing domain.
    system_domain="${env}.c2c.cf-app.com"
  else
    system_domain="${env}.routing.cf-app.com"
  fi

  cf api "api.${system_domain}" --skip-ssl-validation
  cf auth admin "${password}"

  if [ -n "${uaa_password}" ]; then
    uaac target "login.${system_domain}" --skip-ssl-validation
    uaac token client get admin -s "${uaa_password}"
  fi

  cf_seed
}

lookup_env() {
  local name=${1}

  ls ~/workspace/networking-oss-deployments/environments/$1/bbl-state > /dev/null 2>&1
  exit_code=$?
  if [[ $exit_code -eq 0 ]]; then
    echo "${HOME}/workspace/networking-oss-deployments/environments/$1/bbl-state"
    return
  fi

  ls ~/workspace/networking-oss-deployments/environments/$1 > /dev/null 2>&1
  exit_code=$?
  if [[ $exit_code -eq 0 ]]; then
    echo "${HOME}/workspace/networking-oss-deployments/environments/$1"
    return
  fi
}

cf_seed() {
  cf create-org o
  cf create-space -o o s
  cf target -o o -s s
}
