#!/usr/bin/env bash

{
  # install depedence
  sudo pacman -Sy --needed --noconfirm git man vim curl fzf
} && {
  # download dotfiles
  dir=/home/an9wer/Naruto/werice
  git clone --depth 1 https://github.com/an9wer/werice.git ${dir}
}
