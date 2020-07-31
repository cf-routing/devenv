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
  ruby-dev \
  silversearcher-ag \
  software-properties-common \
  tmux \
  tree \
  wget \
  zlib1g-dev \

sudo ln -s $(which fdfind) /usr/bin/fd

# last update
apt-get update

# install the rest
apt-get install -yq azure-cli

# install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8
source "$HOME/.asdf/asdf.sh"

# install asdf packages
plugins=(
'kustomize'
)

for plugin in ${plugins[*]}
do
  asdf plugin-add "${plugin}"
done

for plugin in ${plugins[*]}
do
  asdf install "${plugin}" latest
  version=$(asdf list "${plugin}")
  echo "${plugin} ${version}" >> "$HOME/.tool-versions"
done

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

# go get stuff
GOPATH="${HOME}/go" go get -u github.com/dbellotti/cf-target

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
  curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx
  curl -o /usr/share/bash-completion/completions/cf https://raw.githubusercontent.com/cloudfoundry/cli/master/ci/installers/completion/cf
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

# k9s
mkdir /tmp/k9s
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

# fly
wget -O fly "https://networking.ci.cf-app.com/api/v1/cli?arch=amd64&platform=linux"
chmod +x fly
mv fly /usr/local/bin

# kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv kubectl /usr/local/bin/kubectl

# pip3 things
pip3 install yq neovim when-changed

# k14s
curl -L https://k14s.io/install.sh | bash

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

# istioctl
mkdir /tmp/istio
pushd /tmp/istio
  curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.6.4 sh -
  sudo mv istio-*/bin/istioctl /usr/local/bin
popd

# kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.8.1/kind-$(uname)-amd64
chmod +x ./kind
mv ./kind /usr/local/bin/kind

# uaac
sudo gem install cf-uaac
