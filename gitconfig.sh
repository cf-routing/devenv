#!/bin/bash

# For git prompt
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

echo "Symlink the git-authors file to .git-authors..."
ln -sf ${HOME}/workspace/networking-workspace/git-authors ${HOME}/.git-authors

echo "updating all git repos to use 'git co-author'"
git duet as kds # HACK: if not set to anything git duet fails in the following commands
export GIT_DUET_CO_AUTHORED_BY=1
export GIT_DUET_GLOBAL=1
export GIT_DUET_ROTATE_AUTHOR=1
find ~/workspace/ -type d -name '.git' -exec sh -c 'cd {} && cd .. && git init' \;

git config --global url."git@github.com:".pushInsteadOf "https://github.com/"


# git aliases
git config --global alias.last 'log -1 HEAD'

git config --global alias.ci 'duet-commit -v'
git config --global alias.cira 'duet-commit -v --amend --reset-author'
git config --global alias.co 'checkout'
git config --global alias.di 'diff'
git config --global alias.st 'status'

git config --global alias.llog 'log --date=local'
git config --global alias.flog 'log --pretty=fuller --decorate'
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
git config --global alias.lol 'log --graph --decorate --oneline'
git config --global alias.lola 'log --graph --decorate --oneline --all'
git config --global alias.blog 'log origin/master... --left-right'
