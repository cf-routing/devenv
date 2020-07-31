# Setup fzf
# ---------
if [[ ! "$PATH" == */home/pivotal/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/pivotal/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/pivotal/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/pivotal/.fzf/shell/key-bindings.bash"
