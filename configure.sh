#!/bin/bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim
git clone https://github.com/luan/nvim.git ~/.config/nvim

nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall
nvim +GoInstallBinaries +qall

#tmuxfiles
wget -O - https://raw.githubusercontent.com/luan/tmuxfiles/master/install | bash

rm ~/.bash_profile
ln -s ~/workspace/devenv/profile ~/.bash_profile
