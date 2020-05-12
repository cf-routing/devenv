#!/bin/bash

echo 'Adding current user to docker group, you may be promted for your sudo password'
user=$(whoami)
sudo gpasswd -a $user docker

# neovim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim
git clone https://github.com/luan/nvim.git ~/.config/nvim
nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall
nvim +GoInstallBinaries +qall

#tmuxfiles
wget -O - https://raw.githubusercontent.com/luan/tmuxfiles/master/install | bash

# install bash profile
rm ~/.bash_aliases ~/.bash_logout ~/.bash_profile ~/.bashrc ~/.profile
ln -s $(pwd)/.bash* ~/
ln -s $(pwd)/.profile ~/

# fly aliases
ln -s ~/workspace/networking-workspace/flyrc ~/.flyrc
