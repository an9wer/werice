#!/bin/bash

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

command -v slstatus &> /dev/null && slstatus &
command -v dunst &> /dev/null && dunst &

exec dwm
