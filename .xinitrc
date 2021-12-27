#!/bin/bash

has_command() {
  command -v "$1" &> /dev/null
  return $?
}

if has_command xmodmap && [[ -f ~/.Xmodmap ]]; then
  xmodmap ~/.Xmodmap
fi

if has_command slstatus; then
  slstatus &
fi

if has_command dunst; then
  dunst -verbosity crit &
fi

if has_command redshift; then
  redshift -l geoclue2 -t 6500:3500 &
fi

if has_command ibus-daemon; then
  export XMODIFIERS=@im=ibus
  export GTK_IM_MODULE=ibus
  export QT_IM_MODULE=ibus
  ibus-daemon --xim --replace --daemonize
fi

ssh-agent -t $(( 12 * 60 * 60)) dwm
