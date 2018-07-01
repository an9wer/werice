#!/usr/bin/env bash

{
  # install depedence
  pacman -Sy --needed --noconfirm sudo
} && {
  # create group and user
  groupadd -f wheel
  useradd -g wheel -m an9wer
} && {
  # config sudo
  echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel
}
    
