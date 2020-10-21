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

# Custom Nvim config
rm ~/.config/nvim/user/after.vim ~/.config/nvim/user/plug.vim
ln -s $(pwd)/nvim-after.vim ~/.config/nvim/user/after.vim
ln -s $(pwd)/nvim-plug.vim ~/.config/nvim/user/plug.vim

#tmuxfiles
wget -O - https://raw.githubusercontent.com/luan/tmuxfiles/master/install | bash

# install bash profile
shopt -s dotglob
rm ~/.bash_aliases ~/.bash_logout ~/.bash_profile ~/.bashrc ~/.profile
ln -s $(pwd)/dotfiles/* ~/

# fly aliases
ln -s ~/workspace/networking-workspace/flyrc ~/.flyrc

