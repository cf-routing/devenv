#!/bin/bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root"
    exit
fi

export DEBIAN_FRONTEND=noninteractive

workspace_path=/home/pivotal/workspace

apt-get update
apt-get install apt-utils
apt-get update
apt-get install -yq \
  apt-transport-https \
  aria2 \
  asciidoc \
  autoconf \
  autoconf \
  automake \
  awscli \
  bash-completion \
  bison \
  build-essential \
  cowsay \
  curl \
  direnv \
  docker.io \
  fasd \
  fd-find \
  git \
  gpg \
  jq \
  lastpass-cli \
  libffi-dev \
  libgdbm-dev \
  libncurses5-dev \
  libreadline-dev \
  libssl-dev \
  libyaml-dev \
  lsb-release \
  mosh \
  npm \
  openconnect \
  python3-pip \
  ripgrep \
  silversearcher-ag \
  software-properties-common \
  shellcheck \
  tmux \
  tree \
  wget \
  xclip \
  zlib1g-dev \

sudo ln -s $(which fdfind) /usr/bin/fd

# add cf-clis
wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list

apt-get update

# install the rest
apt-get install -yq azure-cli cf7-cli

curl -o /usr/share/bash-completion/completions/cf https://raw.githubusercontent.com/cloudfoundry/cli/master/ci/installers/completion/cf

# install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# install golang the right way
mkdir -p /tmp/installscratch
cd /tmp/installscratch
wget https://dl.google.com/go/go1.15.3.linux-amd64.tar.gz
tar -xvf go*
rm -rf /usr/local/go
mv go /usr/local
rm -rf /tmp/installscratch

# install user specific programs as pivotal
sudo -u pivotal /home/pivotal/workspace/devenv/install-as-pivotal.sh

# neovim
sudo snap install nvim --classic

# git-duet
mkdir -p /tmp/git-duet
cd
pushd /tmp/git-duet
  url=$(curl -s https://api.github.com/repos/git-duet/git-duet/releases | jq -r '.[0].assets[] | select(.name=="linux_amd64.tar.gz").browser_download_url')
  wget $url
  tar -xvf linux_amd64.tar.gz
  mv * /usr/local/bin/
popd

# git-duet
mkdir -p /tmp/sshb0t
pushd /tmp/sshb0t
  url=$(curl -s https://api.github.com/repos/genuinetools/sshb0t/releases | jq -r '.[0].assets[] | select(.name=="sshb0t-linux-amd64").browser_download_url')
  wget -O sshb0t $url
  chmod +x sshb0t
  mv sshb0t /usr/local/bin/
popd


# bosh
mkdir -p /tmp/bosh
pushd /tmp/bosh
url=$(curl -s https://api.github.com/repos/cloudfoundry/bosh-cli/releases | jq -r '.[0].assets[] | select(.name | contains("linux-amd64")).browser_download_url')
  wget -O bosh "$url"
  chmod +x bosh
  mv bosh /usr/local/bin/
popd

# k9s
mkdir -p /tmp/k9s
pushd /tmp/k9s
url=$(curl -s https://api.github.com/repos/derailed/k9s/releases | jq -r '.[0].assets[] | select(.name | contains("Linux_x86_64")).browser_download_url')
  wget -O k9s.tar.gz "$url"
  tar -xvf k9s.tar.gz
  chmod +x k9s
  mv k9s /usr/local/bin/
popd

# bbl
bbl_version="8.4.0"
wget https://github.com/cloudfoundry/bosh-bootloader/releases/download/v${bbl_version}/bbl-v${bbl_version}_linux_x86-64 -P /tmp && \
mv /tmp/bbl-* /usr/local/bin/bbl && \
cd /usr/local/bin && \
chmod +x bbl

#credhub cli
credhub_cli_version="2.7.0"
wget https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/${credhub_cli_version}/credhub-linux-${credhub_cli_version}.tgz -P /tmp && \
tar xzvf /tmp/credhub-linux-${credhub_cli_version}.tgz -C /usr/local/bin && \
chmod +x /usr/local/bin/credhub

# kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv kubectl /usr/local/bin/kubectl

# pip3 things
pip3 install yq neovim when-changed

# k14s
curl -L https://k14s.io/install.sh | bash

# istioctl
mkdir -p /tmp/istio
pushd /tmp/istio
  curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.6.8 sh -
  sudo mv istio-*/bin/istioctl /usr/local/bin
popd

# kiln
mkdir -p /tmp/kiln
pushd /tmp/kiln
  url=$(curl -s https://api.github.com/repos/pivotal-cf/kiln/releases | jq -r '.[0].assets[] | select((.name | contains("linux")) and (.name | contains("tar"))).browser_download_url')
  curl -L "${url}" | tar -zx
  sudo install kiln /usr/local/bin/kiln
popd

# om cli
mkdir -p /tmp/om
pushd /tmp/om
  url=$(curl -s https://api.github.com/repos/pivotal-cf/om/releases | jq -r '.[0].assets[] | select((.name | contains("linux")) and (.name | contains("tar"))).browser_download_url')
  curl -L "${url}" | tar -zx
  sudo install om /usr/local/bin/om
popd

# certstrap
mkdir -p /tmp/certstrap
pushd /tmp/certstrap
  url=$(curl -s https://api.github.com/repos/square/certstrap/releases | jq -r '.[0].assets[] | select((.name | contains("linux"))).browser_download_url')
  curl -L "${url}" --output certstrap
  sudo install certstrap /usr/local/bin/certstrap
popd

# ctlptl
mkdir -p /tmp/ctlptl
pushd /tmp/ctlptl
  ctlptl_version="0.4.1"
  url="https://github.com/tilt-dev/ctlptl/releases/download/v${ctlptl_version}/ctlptl.${ctlptl_version}.linux.x86_64.tar.gz"
  curl -L "${url}" | tar -zx
  sudo mv ctlptl /usr/local/bin/ctltptl
popd

# tilt
curl -fsSL https://raw.githubusercontent.com/tilt-dev/tilt/master/scripts/install.sh | bash
# avoid conflicts with tilt ruby package
sudo mv /usr/local/bin/tilt /usr/local/bin/tlt


# Overwrite /etc/resolv.conf
# This is necessary because openconnect will want to overwrite the file when it
# is connected to a vpn, which doesn't play nicely with systemd-resolved
# because systemd-resolved can potentially overwrite the changes by openconnect
# at any time without openconnect knowing. It is therefore, easier to only have
# a single process attempt to change /etc/resolv.conf at any time.

rm -f /etc/resolv.conf
cat > /etc/resolv.conf <<EOF
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

# downloaded from https://drive.google.com/a/pivotal.io/file/d/1GxaJGgvoTapDjdq1J3qCkxRBAztIbtOQ/view?usp=sharing
# also, see instructions at:
# https://sites.google.com/a/pivotal.io/pivotal-it/office-equipment/networking/pivotal-vpn/global-protect#TOC-Linux-Installation
dpkg -i "$workspace_path/tas-runtime/GlobalProtect_deb-5.1.0.0-101.deb"

