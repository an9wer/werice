#!/bin/sh

dbus-launch --exit-with-session -- sh -c '
COMMAND="command -v "

if $COMMAND xmodmap && $COMMAND setxkbmap && [ -f ~/.Xmodmap ]; then
	setxkbmap -variant altgr-intl
	xmodmap ~/.Xmodmap
fi

if $COMMAND slstatus; then
  slstatus &
fi

if $COMMAND dunst; then
  dunst -verbosity crit --startup_notification &
fi

if $COMMAND picom; then
  picom --daemon
fi

if $COMMAND unclutter; then
  unclutter --timeout 5 --ignore-scrolling --jitter 50 --fork
fi

if $COMMAND redshift; then
  /usr/libexec/geoclue-2.0/demos/agent &
  redshift &
fi

if $COMMAND ibus-daemon; then
  export XMODIFIERS=@im=ibus
  export GTK_IM_MODULE=ibus
  export QT_IM_MODULE=ibus
  ibus-daemon --xim --replace --daemonize
fi

ssh-agent -t $((12 * 60 * 60)) dwm
'
