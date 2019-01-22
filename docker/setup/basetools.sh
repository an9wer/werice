#!/usr/bin/env bash

packages=(
  m4
  gcc
  make
  git
  vim
  man-pages
  dosfstools  # for 'mkfs.fat' command
  dnsutils    # for 'dig' command
  iproute2    # for 'ip' command
  bash-completion
)

pacman -Sy --needed --noconfirm ${packages[@]}
