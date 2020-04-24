#!/bin/bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Not running as root"
    exit
fi

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install apt-utils
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
  curl \
  direnv \
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
  npm \
  python3-pip \
  ripgrep \
  silversearcher-ag \
  software-properties-common \
  tmux \
  wget \
  zlib1g-dev \

sudo ln -s $(which fdfind) /usr/bin/fd

# last update
apt-get update

# install the rest
apt-get install -yq azure-cli #fasd

# neovim
wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim.appimage
chmod +x nvim.appimage
mv nvim.appimage /usr/local/bin/nvim

# install golang the right way
mkdir -p /tmp/installscratch
cd /tmp/installscratch
wget https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz
tar -xvf go*
rm -rf /usr/local/go
mv go /usr/local
rm -rf /tmp/installscratch

# ruby TODO figure out a better way to do this
#gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
#curl -sSL https://get.rvm.io | bash -s stable --ruby

# git-duet
mkdir /tmp/git-duet
pushd /tmp/git-duet
  url=$(curl -s https://api.github.com/repos/git-duet/git-duet/releases | jq -r '.[0].assets[] | select(.name=="linux_amd64.tar.gz").browser_download_url')
  wget $url
  tar -xvf linux_amd64.tar.gz
  mv * /usr/local/bin/
popd

# git-duet
mkdir /tmp/git-duet
pushd /tmp/git-duet
  url=$(curl -s https://api.github.com/repos/genuinetools/sshb0t/releases | jq -r '.[0].assets[] | select(.name=="sshb0t-linux-amd64").browser_download_url')
  wget -O sshb0t $url
  chmod +x sshb0t
  mv sshb0t /usr/local/bin/
popd

# cf
mkdir /tmp/cf
pushd /tmp/cf
  wget -O cf "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=6.51.0&source=github-rel"
  chmod +x cf
  mv cf /usr/local/bin
popd

# bosh
mkdir /tmp/bosh
pushd /tmp/bosh
url=$(curl -s https://api.github.com/repos/cloudfoundry/bosh-cli/releases | jq -r '.[0].assets[] | select(.name | contains("linux-amd64")).browser_download_url')
  wget -O bosh "$url"
  chmod +x bosh
  mv bosh /usr/local/bin/
popd

# fly
wget -O fly "https://networking.ci.cf-app.com/api/v1/cli?arch=amd64&platform=linux"
chmod +x fly
mv fly /usr/local/bin

# kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv kubectl /usr/local/bin/kubectl

# the correct yq
pip3 install yq neovim
