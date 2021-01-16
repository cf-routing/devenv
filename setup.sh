#!/bin/bash

workspaceDir="${HOME}/workspace"
devenvDir="${workspaceDir}/devenv"

if [[ ! -d "${devenvDir}" ]]; then
    mkdir -p "${workspaceDir}"
    printf "devenv not found.\nCloning the devenv scripts\n"
    git clone "https://github.com/cf-routing/devenv.git" "${devenvDir}"
fi

echo "Cloning our team project repos"
"${devenvDir}/cloner.sh"

echo "Installing required packages and tools, you may be prompted for your sudo password."
sudo "${devenvDir}/install.sh"
"${devenvDir}/configure.sh"
"${devenvDir}/gitconfig.sh"

echo "All done! Disconnect and log back in to ensure you have everything."
echo "Some repositories can't be cloned without a private key, install your identity (with pivotal_login or similar) and run ${devenvDir}/cloner.sh to get the rest."
