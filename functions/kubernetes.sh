#!/bin/bash

function kube_run_dnstools() {
  kubectl run -it --rm --restart=Never --image=infoblox/dnstools:latest dnstools ${@}
}
