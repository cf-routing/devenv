#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install apt-utils
apt-get install -yq git software-properties-common curl apt-transport-https lsb-release gpg asciidoc aria2 autoconf automake awscli bash-completion tmux wget npm

#add repos
add-apt-repository ppa:gophers/archive
add-apt-repository ppa:neovim-ppa/stable
# add-apt-repository ppa:aacebedo/fasd

curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | \
    tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    tee /etc/apt/sources.list.d/azure-cli.list

# last update
apt-get update

# install the rest
apt-get install -yq neovim golang-1.11-go azure-cli #fasd


