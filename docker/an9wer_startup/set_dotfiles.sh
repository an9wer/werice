#!/usr/bin/env bash

{
  # install depedence
  sudo pacman -Sy --needed --noconfirm git man vim curl fzf
} && {
  # download dotfiles
  dir=/home/an9wer/mydotfiles
  git clone --depth 1 https://github.com/an9wer/mydotfiles.git ${dir}
} && {
  # install dotfiles
  echo 0 | ${dir}/bash/install.sh
}
