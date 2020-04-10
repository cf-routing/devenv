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
  libffi-dev \
  libgdbm-dev \
  libncurses5-dev \
  libreadline-dev \
  libssl-dev \
  libyaml-dev \
  lsb-release \
  npm \
  ripgrep \
  silversearcher-ag \
  software-properties-common \
  tmux \
  wget \
  zlib1g-dev \

sudo ln -s $(which fdfind) /usr/bin/fd

#add repos
# add-apt-repository ppa:aacebedo/fasd

# azure cli
curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | \
    tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
    tee /etc/apt/sources.list.d/azure-cli.list

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

# ruby
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby
