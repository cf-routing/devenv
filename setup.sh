#!/bin/bash

USERNAME=$(whoami)
echo "Installing as $USERNAME"

mkdir -p workspace
cd workspace
echo "Cloning the devenv scripts"
git clone https://github.com/cf-routing/devenv.git

cd devenv
echo "Cloning our team project repos"
./cloner.sh
echo "Installing required packages and tools, you may be prompted for your sudo password."
sudo ./install.sh $USERNAME
./configure.sh
./gitconfig.sh
cd ~

echo "All done! Disconnect and log back in to ensure you have everything."
echo "Some repositories can't be cloned without a private key, install your identity (with pivotal_login or similar) and run ./workspace/devenv/cloner.sh to get the rest."
