#!/bin/bash

# install asdf
git clone https://github.com/asdf-vm/asdf.git /home/pivotal/.asdf --branch v0.7.8
source "/home/pivotal/.asdf/asdf.sh"

# install asdf packages
plugins=(
'kustomize'
'kind'
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
