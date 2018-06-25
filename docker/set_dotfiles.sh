#!/usr/bin/env bash

{
  # install depedence
  pacman -Sy --needed --noconfirm git man vim curl fzf
} && {
  # download dotfiles
  dir=/usr/local/src/mydotfiles
  git clone --depth 1 https://github.com/an9wer/mydotfiles.git ${dir}
  cd ${dir} && git submodule update --init --recursive
} && {
  # install dotfiles
  ${dir}/bash/install.sh
}
