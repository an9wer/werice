#!/usr/bin/env bash

{
  # install depedence
  pacman -Sy --needed --noconfirm git gcc make
  pacman -Sy --needed --noconfirm libzip libcurl-gnutls pkg-config
} && {
  # install tldr
  dir=/usr/local/src/tldr
  git clone --depth 1 https://github.com/tldr-pages/tldr-cpp-client.git ${dir}
  cd ${dir} && make && make install
}
