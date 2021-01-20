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

mkdir -p ~/workspace
mkdir -p ~/go


echo "Cloning all of the repos we work on..."

# linux / shell / general
# base16-shell: For the porple
clone_if_not_exist "https://github.com/chriskempson/base16-shell" "${HOME}/.config/base16-shell"

# Unpack utility for recursive untar/unzip. Useful for log files from support
clone_if_not_exist "git@github.com:stephendotcarter/unpack.git" "${HOME}/workspace/unpack"



# Cloud Foundry / TAS (Runtime), in general
# TAS Journey Runtime Ecosystem repo
clone_if_not_exist "git@github.com:pivotal/tas-runtime" "${HOME}/workspace/tas-runtime"

# Bosh Deployment: We usually use this to bump golang in our releases
clone_if_not_exist "https://github.com/cloudfoundry/bosh-deployment" "${HOME}/workspace/bosh-deployment"

# CF Deployment: We use it to deploy Cloud Foundries
clone_if_not_exist "https://github.com/cloudfoundry/cf-deployment" "${HOME}/workspace/cf-deployment"

# CF Deployment Concourse Tasks: We use it to deploy Concourses
clone_if_not_exist "https://github.com/cloudfoundry/cf-deployment-concourse-tasks" "${HOME}/workspace/cf-deployment-concourse-tasks"

# CF Acceptance Tests: 🐱 🐱 or CATS. Happy path integration tests for CF
clone_if_not_exist "https://github.com/cloudfoundry/cf-acceptance-tests" "${GOPATH}/src/code.cloudfoundry.org/cf-acceptance-tests"

# TAS Tiles
clone_if_not_exist "git@github.com:pivotal-cf/p-runtime.git" "${HOME}/workspace/p-runtime"
clone_if_not_exist "git@github.com:pivotal-cf/p-isolation-segment.git" "${HOME}/workspace/p-isolation-segment"
clone_if_not_exist "git@github.com:pivotal-cf/p-windows-runtime-2016.git" "${HOME}/workspace/p-windows-runtime-2016"

# smith CLI for interacting with toolsmiths envs
clone_if_not_exist "git@github.com:pivotal/smith" "${HOME}/workspace/smith"



# networking
# NATS Release: Inherited from Release Integration. We now own this release, which deploys NATS, which is used in CF
clone_if_not_exist "https://github.com/cloudfoundry/nats-release" "${GOPATH}/src/code.cloudfoundry.org/nats-release"

# CF Networking Release: BOSH release for policy-based container networking in Cloud Foundry
clone_if_not_exist "https://github.com/cloudfoundry/cf-networking-release" "${HOME}/workspace/cf-networking-release"

# cf-networking-helpers: contains various helper tools used in cf-networking and silk releases
clone_if_not_exist "https://github.com/cloudfoundry/cf-networking-helpers.git" "${HOME}/workspace/cf-networking-helpers"

# Routing Release: BOSH Release home to the Gorouter, TCP router, and a bunch of other routing related things. Spelunk! Refactor!
clone_if_not_exist "https://github.com/cloudfoundry/routing-release" "${HOME}/workspace/routing-release"

# Used in routing-release/ci
clone_if_not_exist "https://github.com/cf-routing/doctorroute.git" "${HOME}/workspace/doctorroute"

# Silk release: BOSH Release of the Silk CNI plugin
clone_if_not_exist "https://github.com/cloudfoundry/silk-release" "${HOME}/workspace/silk-release"

# Silk: home to Silk and its components (silk-controller, silk-daemon and silk-cni)
clone_if_not_exist "https://github.com/cloudfoundry/silk" "${HOME}/workspace/silk"

# Route Registrar: broadcasts routes to the gorouter
clone_if_not_exist "https://github.com/cloudfoundry/route-registrar" "${HOME}/workspace/route-registrar"

# Routing API: interface for registering and deregistering routes for internal & external clients
clone_if_not_exist "https://github.com/cloudfoundry/routing-api" "${HOME}/workspace/routing-api"

# Routing Acceptance Tests
clone_if_not_exist "https://github.com/cloudfoundry/routing-acceptance-tests" "${HOME}/workspace/routing-acceptance-tests"

# Networking OSS Deployments
clone_if_not_exist "git@github.com:cloudfoundry/networking-oss-deployments.git" "${HOME}/workspace/networking-oss-deployments"

# Routing Support Notes: List of support tickets, past and present, and a handy template to start your own.
clone_if_not_exist "git@github.com:pivotal/routing-support-notes" "${HOME}/workspace/routing-support-notes"

# Pivotal Networking CI -- pipeline and tasks for pivotal ci
clone_if_not_exist "git@github.com:pivotal/pivotal-networking-ci" "${HOME}/workspace/pivotal-networking-ci"

# App connectivy bot (Slackbot to nudge NSX-T questions to be asked elsewhere)
clone_if_not_exist "git@github.com:pivotal/app-connectivity-program-slackbot.git" "${HOME}/workspace/app-connectivity-program-slackbot"

# Community bot (script to get recently updated Github issues)
clone_if_not_exist "git@github.com:cf-routing/community-bot.git" "${HOME}/workspace/community-bot"



# Diego
clone_if_not_exist "git@github.com:cloudfoundry/deployments-diego.git"             "${HOME}/workspace/deployments-diego"
clone_if_not_exist "git@github.com:cloudfoundry/diego-team.git"                    "${HOME}/workspace/diego-team"
clone_if_not_exist "https://github.com/cloudfoundry/diego-release"                 "${HOME}/workspace/diego-release"
clone_if_not_exist "https://github.com/cloudfoundry/archiver"                      "${HOME}/workspace/archiver"
clone_if_not_exist "https://github.com/cloudfoundry/auction"                       "${HOME}/workspace/auction"
clone_if_not_exist "https://github.com/cloudfoundry/auctioneer"                    "${HOME}/workspace/auctioneer"
clone_if_not_exist "https://github.com/cloudfoundry/bbs"                           "${HOME}/workspace/bbs"
clone_if_not_exist "https://github.com/cloudfoundry/benchmarkbbs"                  "${HOME}/workspace/benchmarkbbs"
clone_if_not_exist "https://github.com/cloudfoundry/bytefmt"                       "${HOME}/workspace/bytefmt"
clone_if_not_exist "https://github.com/cloudfoundry/cacheddownloader"              "${HOME}/workspace/cacheddownloader"
clone_if_not_exist "https://github.com/cloudfoundry/certsplitter"                  "${HOME}/workspace/certsplitter"
clone_if_not_exist "https://github.com/cloudfoundry/cfdot"                         "${HOME}/workspace/cfdot"
clone_if_not_exist "https://github.com/cloudfoundry/cfhttp"                        "${HOME}/workspace/cfhttp"
clone_if_not_exist "https://github.com/cloudfoundry/clock"                         "${HOME}/workspace/clock"
clone_if_not_exist "https://github.com/cloudfoundry/debugserver"                   "${HOME}/workspace/debugserver"
clone_if_not_exist "https://github.com/cloudfoundry/diego-logging-client"          "${HOME}/workspace/diego-logging-client"
clone_if_not_exist "https://github.com/cloudfoundry/diego-ssh"                     "${HOME}/workspace/diego-ssh"
clone_if_not_exist "https://github.com/cloudfoundry/diego-upgrade-stability-tests" "${HOME}/workspace/diego-upgrade-stability-tests"
clone_if_not_exist "https://github.com/cloudfoundry/dockerapplifecycle"	           "${HOME}/workspace/dockerapplifecycle"
clone_if_not_exist "https://github.com/cloudfoundry/durationjson"                  "${HOME}/workspace/durationjson"
clone_if_not_exist "https://github.com/cloudfoundry/executor"                      "${HOME}/workspace/executor"
clone_if_not_exist "https://github.com/cloudfoundry/fileserver"                    "${HOME}/workspace/fileserver"
clone_if_not_exist "https://github.com/cloudfoundry/healthcheck"                   "${HOME}/workspace/healthcheck"
clone_if_not_exist "https://github.com/cloudfoundry/inigo"                         "${HOME}/workspace/inigo"
clone_if_not_exist "https://github.com/cloudfoundry/lager"                         "${HOME}/workspace/lager"
clone_if_not_exist "https://github.com/cloudfoundry/localip"                       "${HOME}/workspace/localip"
clone_if_not_exist "https://github.com/cloudfoundry/locket"                        "${HOME}/workspace/locket"
clone_if_not_exist "https://github.com/cloudfoundry/rep"                           "${HOME}/workspace/rep"
clone_if_not_exist "https://github.com/cloudfoundry/route-emitter"                 "${HOME}/workspace/route-emitter"
clone_if_not_exist "https://github.com/cloudfoundry/vizzini"                       "${HOME}/workspace/vizzini"
clone_if_not_exist "https://github.com/cloudfoundry/workpool"                      "${HOME}/workspace/workpool"

# Garden
clone_if_not_exist "https://github.com/cloudfoundry/garden-runc-release"        "${HOME}/workspace/garden-runc-release"

# Logging & Metrics
clone_if_not_exist "https://github.com/cloudfoundry/cf-drain-cli"                  "${HOME}/workspace/cf-drain-cli"
clone_if_not_exist "https://github.com/cloudfoundry/go-log-cache"                  "${HOME}/workspace/go-log-cache"
clone_if_not_exist "https://github.com/cloudfoundry/go-loggregator"                "${HOME}/workspace/go-loggregator"
clone_if_not_exist "https://github.com/cloudfoundry/log-cache-cli"                 "${HOME}/workspace/log-cache-cli"
clone_if_not_exist "https://github.com/cloudfoundry/log-cache-release"             "${HOME}/workspace/log-cache-release"
clone_if_not_exist "https://github.com/cloudfoundry/loggregator-agent-release"     "${HOME}/workspace/loggregator-agent-release"
clone_if_not_exist "https://github.com/cloudfoundry/loggregator-api"               "${HOME}/workspace/loggregator-api"
clone_if_not_exist "https://github.com/cloudfoundry/loggregator-release"           "${HOME}/workspace/loggregator-release"
clone_if_not_exist "https://github.com/cloudfoundry-incubator/loggregator-tools"   "${HOME}/workspace/loggregator-tools"
clone_if_not_exist "https://github.com/cloudfoundry/syslog-release"                "${HOME}/workspace/syslog-release"
clone_if_not_exist "https://github.com/cloudfoundry/bosh-system-metrics-forwarder" "${HOME}/workspace/bosh-system-metrics-forwarder"
clone_if_not_exist "https://github.com/cloudfoundry/bosh-system-metrics-server"    "${HOME}/workspace/bosh-system-metrics-server"
clone_if_not_exist "https://github.com/cloudfoundry/go-metric-registry"            "${HOME}/workspace/go-metric-registry"
clone_if_not_exist "https://github.com/cloudfoundry/metrics-discovery-release"     "${HOME}/workspace/metrics-discovery-release"
clone_if_not_exist "git@github.com:pivotal-cf/metric-registrar-cli"                "${HOME}/workspace/metric-registrar-cli"
clone_if_not_exist "git@github.com:pivotal-cf/metric-registrar-deployments"        "${HOME}/workspace/metric-registrar-deployments"
clone_if_not_exist "git@github.com:pivotal-cf/metric-registrar-release"            "${HOME}/workspace/metric-registrar-release"


# Logging & Metrics to deprecate (maybe)
clone_if_not_exist "https://github.com/cloudfoundry/loggregator-ci"                 "${HOME}/workspace/loggregator-ci"
clone_if_not_exist "https://github.com/cloudfoundry/noisy-neighbor-nozzle"          "${HOME}/workspace/noisy-neighbor-nozzle"
clone_if_not_exist "https://github.com/cloudfoundry/deployments-loggregator"        "${HOME}/workspace/deployments-loggregator"
clone_if_not_exist "https://github.com/cloudfoundry/service-metrics-release"        "${HOME}/workspace/service-metrics-release"
clone_if_not_exist "https://github.com/cloudfoundry/statsd-injector-release"        "${HOME}/workspace/statsd-injector-release"
clone_if_not_exist "https://github.com/cloudfoundry/system-metrics-release"         "${HOME}/workspace/system-metrics-release"
clone_if_not_exist "https://github.com/cloudfoundry/system-metrics-scraper-release" "${HOME}/workspace/system-metrics-scraper-release"


# Autoscaling & Scheduler
clone_if_not_exist "git@github.com:pivotal-cf/cf-autoscaling-release"              "${HOME}/workspace/cf-autoscaling-release"
clone_if_not_exist "git@github.com:pivotal-cf/pcf-scheduler-release"               "${HOME}/workspace/pcf-scheduler-release"
clone_if_not_exist "git@github.com:pivotal-cf/pcf-scheduler-deployments"           "${HOME}/workspace/pcf-scheduler-deployments"
clone_if_not_exist "git@github.com:pivotal-cf/p-scheduler"                         "${HOME}/workspace/p-scheduler"


# Docs repos (that we know about)
clone_if_not_exist "git@github.com:cloudfoundry/docs-cf-admin.git"                 "${HOME}/workspace/docs-cf-admin"
clone_if_not_exist "git@github.com:cloudfoundry/docs-cloudfoundry-concepts.git"    "${HOME}/workspace/docs-cloudfoundry-concepts"
clone_if_not_exist "git@github.com:cloudfoundry/docs-dev-guide"                    "${HOME}/workspace/docs-dev-guide"
clone_if_not_exist "git@github.com:pivotal-cf/docs-operating-pas.git"              "${HOME}/workspace/docs-operating-pas"
clone_if_not_exist "git@github.com:pivotal-cf/docs-partials"                       "${HOME}/workspace/docs-partials"
clone_if_not_exist "git@github.com:pivotal-cf/docs-pcf-security"                   "${HOME}/workspace/docs-pcf-security"
clone_if_not_exist "git@github.com:cloudfoundry/docs-running-cf"                   "${HOME}/workspace/docs-running-cf"
clone_if_not_exist "https://github.com/cloudfoundry/docs-loggregator"              "${HOME}/workspace/docs-loggregator"
clone_if_not_exist "git@github.com:pivotal-cf/docs-metric-registrar"               "${HOME}/workspace/docs-metric-registrar"
clone_if_not_exist "git@github.com:pivotal-cf/docs-scheduler.git"                  "${HOME}/workspace/docs-scheduler"
clone_if_not_exist "git@github.com:pivotal-cf/docs-pcf-pws.git"                    "${HOME}/workspace/docs-pcf-pws"


# Note: requires VPN access
# Install GlobalProtect (automated in install.sh)
#
# Connect to VPN
# 1. globalprotect connect --portal portal-nasa.vpn.pivotal.io -u ${username}
# 2. Choose 1 (Okta verify)
#
# Install smith
# 1. cd ~/workspace/smith && go install

cd "${HOME}/workspace/"

echo "direnv allow all releases for all repos"
for direnvable in $(find . | grep envrc | sed -e 's/.\/\(.*\)\/.envrc/\1/'); do
  pushd $direnvable
  direnv allow
  popd
done

echo "scripts update all repos"
for release in $(find . | grep "scripts/update$" | sed -e 's/.\/\(.*\)\/scripts\/update/\1/'); do
  pushd $release
  ./scripts/update
  popd
done

