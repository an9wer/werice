#!/usr/bin/env bash

{ # Install depedence
  pacman -Sy --needed --noconfirm audit sudo

} && { # Create group and user
  groupadd -f wheel
  useradd -g wheel -m an9wer

} && { # Config sudo
  echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel

}
    
