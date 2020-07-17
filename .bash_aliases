#!/bin/bash

alias watch="watch " # enables alias expansion for commands in watch
                     # i.e. `watch k get pods` will now work

alias vim=nvim
alias vi=nvim

alias gup="git pull --rebase --autostash"
alias gst="git status"
alias gap="git add -p"

alias diff="diff --color"

alias kis="kubectl -n istio-system"
alias kcf="kubectl -n cf-system"
alias kw="kubectl -n cf-workloads"
