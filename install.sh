#!/bin/bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root"
    exit
fi

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -yq apt-utils

# Add apt PPAs
# add cf-clis
curl -L "https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key" | apt-key add -
echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list

# add neovim
add-apt-repository ppa:neovim-ppa/stable

apt-get update
apt-get install -yq \
  apt-transport-https \
  aria2 \
  asciidoc \
  autoconf \
  autoconf \
  automake \
  awscli \
  azure-cli \
  bash-completion \
  bison \
  build-essential \
  cf7-cli \
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
  neovim \
  npm \
  openconnect \
  python3-pip \
  ripgrep \
  shellcheck \
  silversearcher-ag \
  software-properties-common \
  tmux \
  tree \
  wget \
  xclip \
  zlib1g-dev

ln -s "$(command -v fdfind)" /usr/bin/fd

curl -o "/usr/share/bash-completion/completions/cf" "https://raw.githubusercontent.com/cloudfoundry/cli/master/ci/installers/completion/cf"

# install golang the right way
mkdir -p /tmp/installscratch
pushd /tmp/installscratch
  curl -L "https://dl.google.com/go/$(curl https://golang.org/VERSION?m=text).linux-amd64.tar.gz" | tar -zx
  rm -rf /usr/local/go
  mv go /usr/local
popd

# install user specific programs as pivotal
sudo -u pivotal "/home/pivotal/workspace/devenv/install-as-pivotal.sh"

# git-duet
mkdir -p /tmp/git-duet
pushd /tmp/git-duet
  url="$(curl -s https://api.github.com/repos/git-duet/git-duet/releases | jq -r '.[0].assets[] | select(.name=="linux_amd64.tar.gz").browser_download_url')"
  curl -L "${url}" | tar -zx
  install ./* /usr/local/bin/
popd

# git-duet
mkdir -p /tmp/sshb0t
pushd /tmp/sshb0t
  url="$(curl -s https://api.github.com/repos/genuinetools/sshb0t/releases | jq -r '.[0].assets[] | select(.name=="sshb0t-linux-amd64").browser_download_url')"
  curl -L "${url}" -o sshb0t
  install sshb0t /usr/local/bin/
popd

# bosh
mkdir -p /tmp/bosh
pushd /tmp/bosh
url="$(curl -s https://api.github.com/repos/cloudfoundry/bosh-cli/releases | jq -r '.[0].assets[] | select(.name | contains("linux-amd64")).browser_download_url')"
  curl -L "${url}" -o bosh
  install bosh /usr/local/bin/
popd

# bbl
mkdir -p /tmp/bbl
pushd /tmp/bbl
  url=$(curl -s https://api.github.com/repos/cloudfoundry/bosh-bootloader/releases | jq -r '.[0].assets[] | select((.name | contains("linux"))).browser_download_url')
  curl -L "${url}" -o bbl
  install bbl /usr/local/bin/bbl
popd

#credhub cli
mkdir -p /tmp/credhub-cli
pushd /tmp/credhub-cli
  url="$(curl -s https://api.github.com/repos/cloudfoundry-incubator/credhub-cli/releases | jq -r '.[0].assets[] | select((.name | contains("linux")) and (.name | contains("tgz"))).browser_download_url')"
  curl -L "${url}" | tar -zx
  install credhub /usr/local/bin/credhub
popd

# pip3 things
pip3 install yq neovim when-changed

# kiln
mkdir -p /tmp/kiln
pushd /tmp/kiln
  url="$(curl -s https://api.github.com/repos/pivotal-cf/kiln/releases | jq -r '.[0].assets[] | select((.name | contains("linux")) and (.name | contains("tar"))).browser_download_url')"
  curl -L "${url}" | tar -zx
  install kiln /usr/local/bin/kiln
popd

# om cli
mkdir -p /tmp/om
pushd /tmp/om
  url="$(curl -s https://api.github.com/repos/pivotal-cf/om/releases | jq -r '.[0].assets[] | select((.name | contains("linux")) and (.name | contains("tar"))).browser_download_url')"
  curl -L "${url}" | tar -zx
  install om /usr/local/bin/om
popd

# certstrap
mkdir -p /tmp/certstrap
pushd /tmp/certstrap
  url="$(curl -s https://api.github.com/repos/square/certstrap/releases | jq -r '.[0].assets[] | select((.name | contains("linux"))).browser_download_url')"
  curl -L "${url}" -o certstrap
  install certstrap /usr/local/bin/certstrap
popd


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
gpDebPath="$(compgen -G /home/pivotal/GlobalProtect_deb-*.deb )"
if [[ -f "${gpDebPath}" ]]; then
  dpkg -i "${gpDebPath}"
fi
