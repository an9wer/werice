# This file is sourced by all *interactive* bash shells on startup,
# if not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Load custom bashrc
if [[ -d $HOME/.bashrc.d ]]; then
  for rc in $(ls $HOME/.bashrc.d/*.sh); do
    source "$rc"
  done; unset rc
fi

# Scripts path
if [[ -d $HOME/.scripts && ! "$PATH" =~ "$HOME/scripts" ]]; then
  export PATH="$HOME/.scripts:$PATH"
fi

# Suckless path (used by collapse)
if [[ -d $HOME/.suckless/bin && ! "$PATH" =~ "$HOME/.suckless/bin" ]]; then
  export PATH="$HOME/.suckless/bin:$PATH"
fi

# vim: set filetype=sh:
