# Setup fzf
# ---------
if [[ ! "$PATH" == */home/Kieran/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/Kieran/.fzf/bin"
fi

source <(fzf --zsh)
