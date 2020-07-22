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

alias kis="kubectl -n istio-system"
complete -F __start_kubectl kis
alias kcf="kubectl -n cf-system"
complete -F __start_kubectl kcf
alias kw="kubectl -n cf-workloads"
complete -F __start_kubectl kw
