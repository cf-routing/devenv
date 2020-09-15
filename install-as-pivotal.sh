#!/bin/bash

cd /home/pivotal || exit 1

# install asdf
git clone https://github.com/asdf-vm/asdf.git /home/pivotal/.asdf --branch v0.7.8
source "/home/pivotal/.asdf/asdf.sh"

# install asdf packages
plugins=(
'kustomize'
'kind'
'clusterctl'
)

for plugin in ${plugins[*]}
do
  asdf plugin-add "${plugin}"
done

for plugin in ${plugins[*]}
do
  asdf install "${plugin}" latest
  version=$(asdf list "${plugin}")
  echo "${plugin} ${version}" >> "/home/pivotal/.tool-versions"
done

git clone --depth 1 https://github.com/junegunn/fzf.git /home/pivotal/.fzf
/home/pivotal/.fzf/install --key-bindings --completion --no-update-rc

# go get stuff
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:/home/xander/.local/bin:$HOME/go/bin/
go get -u github.com/dbellotti/cf-target
go get github.com/onsi/ginkgo/ginkgo
go get github.com/onsi/gomega/...
