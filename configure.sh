#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo 'Adding current user to docker group, you may be promted for your sudo password'
user=$(whoami)
sudo gpasswd -a "${user}" docker

# neovim
curl -fLo "${HOME}/.vim/autoload/plug.vim" --create-dirs \
    "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
mkdir -p "${HOME}/.config/nvim"
git clone "https://github.com/luan/nvim.git" "${HOME}/.config/nvim"
nvim +PlugInstall +qall
nvim +ConfigInstallLanguageServers +qall
nvim +UpdateRemotePlugins +qall
nvim +GoInstallBinaries +qall

# Add custom Nvim config
rm "${HOME}/.config/nvim/user/after.vim" "${HOME}/.config/nvim/user/plug.vim"
ln -s "${DIR}/nvim-after.vim" "${HOME}/.config/nvim/user/after.vim"
ln -s "${DIR}/nvim-plug.vim" "${HOME}/.config/nvim/user/plug.vim"

# tmuxfiles
wget -O - "https://raw.githubusercontent.com/luan/tmuxfiles/master/install" | bash

# support ssh key forwarding, requires having `ssh-add`-ed before ssh-ing onto the machine
cat << EOF >> ~/.ssh/rc
if test "\$SSH_AUTH_SOCK"; then
	ln -sf \$SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
fi
EOF

echo "set-environment -g 'SSH_AUTH_SOCK' ~/.ssh/ssh_auth_sock" >> "${HOME}/.tmux.conf"
echo "set -g update-environment -r" >> ~/.tmux.conf

# install bash profile
shopt -s dotglob # do NOT quote the expansion of the dotfiles
rm -f "${HOME}/.bash_aliases" "${HOME}/.bash_logout" "${HOME}/.bash_profile" "${HOME}/.bashrc" "${HOME}/.profile"
ln -sf ${DIR}/dotfiles/* "${HOME}/"
