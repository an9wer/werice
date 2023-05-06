#!/bin/bash

dbus-launch --exit-with-session -- bash -c '
has_command() {
  command -v "$1" &> /dev/null
  return $?
}

if has_command xmodmap && [[ -f ~/.Xmodmap ]]; then
  setxkbmap -variant altgr-intl
  xmodmap ~/.Xmodmap
fi

if has_command slstatus; then
  slstatus &
fi

if has_command dunst; then
  dunst -verbosity crit --startup_notification &
fi

if has_command redshift; then
  /usr/libexec/geoclue-2.0/demos/agent &
  redshift &
fi

if has_command ibus-daemon; then
  export XMODIFIERS=@im=ibus
  export GTK_IM_MODULE=ibus
  export QT_IM_MODULE=ibus
  ibus-daemon --xim --replace --daemonize
fi

ssh-agent -t $((12 * 60 * 60)) dwm
'
