#!/bin/bash

if [[ $(/usr/bin/id -u) -eq 0 ]]; then
    echo "Don't run me as root"
    exit
fi

clone_if_not_exist() {
  local remote=$1
  local dst_dir="$2"
  echo "Cloning $remote into $dst_dir"
  if [[ ! -d $dst_dir ]]; then
    git clone "$remote" "$dst_dir"
  fi
}

echo "Cloning all of the repos we work on..."

mkdir ~/workspace
mkdir ~/go


echo "Cloning all of the repos we work on..."

# networking-workspace: you might already have this but who knows
clone_if_not_exist "https://github.com/cloudfoundry/networking-workspace.git" "${HOME}/workspace/networking-workspace"

# base16-shell: For the porple
clone_if_not_exist "https://github.com/chriskempson/base16-shell" "${HOME}/.config/base16-shell"

# Deployments Routing:  Pipelines, environment info, helpful scripts
clone_if_not_exist "git@github.com:cloudfoundry/deployments-routing" "${HOME}/workspace/deployments-routing"

# CF Networking Deployments: Private manifests and credentials for C2C CI
clone_if_not_exist "git@github.com:cloudfoundry/cf-networking-deployments" "${HOME}/workspace/cf-networking-deployments"

# Routing Datadog Config: Configure your Data 🐶
clone_if_not_exist "git@github.com:cloudfoundry/routing-datadog-config" "${HOME}/workspace/routing-datadog-config"

# Routing Team Checklists: Checklists (on-call, onboarding) and a kind of helpful wiki
clone_if_not_exist "git@github.com:cloudfoundry/routing-team-checklists" "${HOME}/workspace/routing-team-checklists"

# Networking Program Checklists: Checklists (on-call, onboarding) and a kind of helpful wiki
clone_if_not_exist "git@github.com:cloudfoundry/networking-program-checklists" "${HOME}/workspace/networking-program-checklists"

# Bosh Deployment: We usually use this to bump golang in our releases
clone_if_not_exist "https://github.com/cloudfoundry/bosh-deployment" "${HOME}/workspace/bosh-deployment"

# CF Deployment: We use it to deploy Cloud Foundries
clone_if_not_exist "https://github.com/cloudfoundry/cf-deployment" "${HOME}/workspace/cf-deployment"

# CF Deployment Concourse Tasks: We use it to deploy Concourses
clone_if_not_exist "https://github.com/cloudfoundry/cf-deployment-concourse-tasks" "${HOME}/workspace/cf-deployment-concourse-tasks"

# CF Acceptance Test: 🐱 🐱  or CATS. Happy path integration tests for CF
clone_if_not_exist "https://github.com/cloudfoundry/cf-acceptance-tests" "${GOPATH}/src/code.cloudfoundry.org/cf-acceptance-tests"

# CF Smoke Tests: Quick test that pretty much just pushes an app to verify a successful deployment of CF
clone_if_not_exist "https://github.com/cloudfoundry/cf-smoke-tests" "${GOPATH}/src/code.cloudfoundry.org/cf-smoke-tests"

# NATS Release: Inherited from Release Integration. We now own this release, which deploys NATS, which is used in CF
clone_if_not_exist "https://github.com/cloudfoundry/nats-release" "${GOPATH}/src/code.cloudfoundry.org/nats-release"

# Istio Acceptance Tests: Used to verify Cloud Foundry integration with Istio using real environments and real components
clone_if_not_exist "https://github.com/cloudfoundry/istio-acceptance-tests" "${GOPATH}/src/code.cloudfoundry.org/istio-acceptance-tests"

# Istio Release: BOSH release used to deploy Istio, Envoy, Copilot
clone_if_not_exist "https://github.com/cloudfoundry/istio-release" "${GOPATH}/src/code.cloudfoundry.org/istio-release"

# Istio Workspace: Use this if you want to work outside of your GOPATH and spin up a Vagrant VM for testing (see istio_docker())
clone_if_not_exist "https://github.com/cloudfoundry/istio-workspace" "${HOME}/workspace/istio-workspace"

# Routing API CLI: Used to interact with the Routing API, which can be found in Routing Release
clone_if_not_exist "https://github.com/cloudfoundry/routing-api-cli" "${GOPATH}/src/code.cloudfoundry.org/routing-api-cli"

# CF Networking CI: the DEPRECATED CI repo for Container Networking Release CI
clone_if_not_exist "https://github.com/cloudfoundry/cf-networking-ci" "${HOME}/workspace/cf-networking-ci"

# Toque Scaling: Scaling tests in the C2c CI
clone_if_not_exist "https://github.com/cf-container-networking/toque-scaling" "${HOME}/workspace/toque-scaling"

# Toque Test Helpers: Fixtures for the toque scaling tests
clone_if_not_exist "https://github.com/cf-container-networking/toque-test-helpers" "${HOME}/workspace/toque-test-helpers"

# CF Networking Release: BOSH release for policy-based container networking in Cloud Foundry
clone_if_not_exist "https://github.com/cloudfoundry/cf-networking-release" "${HOME}/workspace/cf-networking-release"

# Routing Perf Release: Used to run performance tests against Routing Release
clone_if_not_exist "https://github.com/cloudfoundry/routing-perf-release" "${GOPATH}/src/code.cloudfoundry.org/routing-perf-release"

# Routing Release: BOSH Release home to the Gorouter, TCP router, and a bunch of other routing related things. Spelunk! Refactor!
clone_if_not_exist "https://github.com/cloudfoundry/routing-release" "${HOME}/workspace/routing-release"

# Routing Sample Apps: Mostly used by developers and PMs for debugging and acceptance. If you don't see what you need, make it and add extensive documentation.
clone_if_not_exist "https://github.com/cloudfoundry/routing-sample-apps" "${HOME}/workspace/routing-sample-apps"

# Docs Book CloudFoundry: You'll need this if you want to make any documentation changes for the Cloud Foundry docs site.
clone_if_not_exist "https://github.com/cloudfoundry/docs-book-cloudfoundry" "${HOME}/workspace/docs-book-cloudfoundry"

# Docs Running CF: You'll need this if you want to run a docs site locally to make sure your changes are OK.
clone_if_not_exist "https://github.com/cloudfoundry/docs-running-cf" "${HOME}/workspace/docs-running-cf"

# Istio Scaling: Used to test the scalability of Istio in a Cloud Foundry deployment
clone_if_not_exist "https://github.com/cloudfoundry/istio-scaling" "${GOPATH}/src/code.cloudfoundry.org/istio-scaling"

# Community Bot: an ever changing tool to help with our community responsibilities
clone_if_not_exist "https://github.com/cf-routing/community-bot" "${GOPATH}/src/github.com/cf-routing/community-bot"

# Zero Downtime Release: BOSH release for testing app availability
clone_if_not_exist "https://github.com/cf-routing/zero-downtime-release" "${HOME}/workspace/zero-downtime-release"

# Diego Release: BOSH release for container scheduling for Cloud Foundry Runtime
clone_if_not_exist "https://github.com/cloudfoundry/diego-release" "${HOME}/workspace/diego-release"

# Capi Release: BOSH release for the Cloud Controller API
clone_if_not_exist "https://github.com/cloudfoundry/capi-release" "${HOME}/workspace/capi-release"

# Garden RunC Release: BOSH release for Garden RunC
clone_if_not_exist "https://github.com/cloudfoundry/garden-runc-release" "${HOME}/workspace/garden-runc-release"

# Silk: Open-source, CNI-compatible container networking fabric
clone_if_not_exist "https://github.com/cloudfoundry/silk" "${GOPATH}/src/code.cloudfoundry.org/silk"

# Cf Networking Helpers: Helpers for running tests?
clone_if_not_exist "https://github.com/cloudfoundry/cf-networking-helpers" "${HOME}/workspace/cf-networking-helpers"

# Istio Sample Apps
clone_if_not_exist "git@github.com:GoogleCloudPlatform/istio-samples.git" "${HOME}/workspace/istio-samples"

# CF K8S Networking
clone_if_not_exist "https://github.com/cloudfoundry/cf-k8s-networking" "${HOME}/workspace/cf-k8s-networking"

# Eirini
clone_if_not_exist "https://github.com/cloudfoundry-incubator/eirini" "${HOME}/workspace/eirini"

# Eirini BOSH Release
clone_if_not_exist "https://github.com/cloudfoundry-community/eirini-bosh-release" "${HOME}/workspace/eirini-bosh-release"

# Networking OSS Deployments
clone_if_not_exist "git@github.com:cloudfoundry/networking-oss-deployments.git" "${HOME}/workspace/networking-oss-deployments"

# Pivotal Only ==============================================================================================

# Routing Support Notes: List of support tickets, past and present, and a handy template to start your own.
clone_if_not_exist "git@github.com:pivotal/routing-support-notes" "${HOME}/workspace/routing-support-notes"

# Scripts for generating Istio config for PKS Routing
clone_if_not_exist "git@github.com:pivotal/k8s-istio-resource-generator" "${GOPATH}/src/github.com/pivotal/k8s-istio-resource-generator"

# PKS Service Mesh repo
clone_if_not_exist "git@github.com:pivotal/ingress-router" "${GOPATH}/src/github.com/pivotal/ingress-router"

# Pivotal Networking CI -- pipeline and tasks for pivotal ci
clone_if_not_exist "git@github.com:pivotal/pivotal-networking-ci" "${GOPATH}/src/github.com/pivotal/pivotal-networking-ci"

# PKS Networking Env Metadata -- env info for pivotal ci
clone_if_not_exist "git@github.com:pivotal/pks-networking-env-metadata" "${GOPATH}/workspace/pks-networking-env-metadata"

# Norsk Config -- for OSL
clone_if_not_exist "git@github.com:pivotal-cf/norsk-config" "${HOME}/workspace/norsk-config"

# Norsk repo for running OSL pipeline tasks locally
clone_if_not_exist "git@github.com:pivotal-cf/norsk.git" "${HOME}/workspace/norsk"

# Istio Envoy OSL scripts
clone_if_not_exist "git@github.com:pivotal/istio-envoy-osl.git" "${HOME}/workspace/istio-envoy-osl"

# Pivotal Intellij IDE Preferences
clone_if_not_exist "git@github.com:pivotal-legacy/pivotal_ide_prefs.git" "${HOME}/workspace/pivotal_ide_prefs"

cd ~/workspace

# direnv allow all releases
for direnvable in $(find . | grep envrc | sed -e 's/.\/\(.*\)\/.envrc/\1/'); do
  cd $direnvable
  direnv allow
  cd ..
done

for release in $(find . | grep "scripts/update$" | sed -e 's/.\/\(.*\)\/scripts\/update/\1/'); do
  cd $release
  ./scripts/update
  cd ..
done

exit 0
