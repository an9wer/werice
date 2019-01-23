#!/bin/bash

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

command -v slstatus &> /dev/null && slstatus &
command -v dunst &> /dev/null && dunst &
command -v fcitx &> /dev/null && fcitx -d

exec dwm
