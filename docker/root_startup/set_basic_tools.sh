#!/usr/bin/env bash

{
  pacman -Sy --needed --noconfirm \
    make \
    gcc \
    git-lfs \
    dosfstools \
    man-pages
}
