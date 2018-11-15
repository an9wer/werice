#!/usr/bin/env bash

{
  packages=(
    make
    gcc
    git-lfs
    man-pages
    dosfstools  # for 'mkfs.fat' command
    dnsutils  # for 'dig' command
    iproute2  # for 'ip' command
  )

  for package in ${packages[@]}; do
    pacman -Sy --needed --noconfirm ${package}
  done

  unset package packages
}
