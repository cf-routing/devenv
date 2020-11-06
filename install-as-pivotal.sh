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
'ruby'
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

# vim-go dependencies so you don't have to run :GoInstallBinaries
#   source: https://github.com/fatih/vim-go/blob/master/plugin/go.vim#L42
go get github.com/klauspost/asmfmt/cmd/asmfmt
go get github.com/go-delve/delve/cmd/dlv
go get github.com/kisielk/errcheck
go get github.com/davidrjenni/reftools/cmd/fillstruct
go get github.com/rogpeppe/godef
go get golang.org/x/tools/cmd/goimports
go get golang.org/x/lint/golint
go get golang.org/x/tools/gopls
go get github.com/golangci/golangci-lint/cmd/golangci-lint
go get github.com/fatih/gomodifytags
go get golang.org/x/tools/cmd/gorename
go get github.com/jstemmer/gotags
go get golang.org/x/tools/cmd/guru
go get github.com/josharian/impl
go get honnef.co/go/tools/cmd/keyify
go get github.com/fatih/motion
go get github.com/koron/iferr
go get github.com/google/addlicense
