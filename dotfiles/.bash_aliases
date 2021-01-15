#!/bin/bash

alias watch="watch " # enables alias expansion for commands in watch
                     # i.e. `watch k get pods` will now work

alias vim=nvim
alias vi=nvim

alias gup="git pull --rebase --autostash"
alias gst="git status"
alias gap="git add -p"

alias diff="diff --color"

alias t="target"

alias reload="source ~/.bash_profile"

alias vpn="sudo openconnect --no-dtls --protocol=gp gp-den2.vmware.com"

alias pbcopy="xclip -sel clip"
alias pbpaste="xclip -o -sel clip"
