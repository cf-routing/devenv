#!/bin/bash

if [ -f ~/.bashrc ]; then
      . ~/.bashrc
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# asdf
[[ -s "$HOME/.asdf/asdf.sh" ]] && source "$HOME/.asdf/asdf.sh"

# Only set the ssh_auth_sock when not using ssh agent forwarding
if [[ -z "${SSH_AUTH_SOCK}" ]]; then
      # always use the same ssh-agent
      # shamelessly lifted from https://unix.stackexchange.com/a/132117/385935
      export SSH_AUTH_SOCK=~/.ssh/ssh-agent.$HOSTNAME.sock
      ssh-add -l 2>/dev/null >/dev/null
      if [ $? -ge 2 ]; then
        ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
      fi
fi
