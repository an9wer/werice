# This file is sourced by bash for login shells.

if shopt -q login_shell; then
  # run startx automatically after login to tty1
  if [[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]]; then
    exec startx
  fi

  # else source bashrc file
  if [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
  fi
fi
