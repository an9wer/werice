#!/usr/bin/env bash

# thx: https://wiki.archlinux.org/index.php/locale

{
  # generate locales
  [[ -f /etc/locale.gen ]] && mv /etc/locale.gen /etc/locale.gen.bak
  echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen && locale-gen
} && {
  # set the locale
  echo 'LANG=en_US.UTF-8' > /etc/locale.conf
}

# after the settings above, run the command `source /etc/profile.d/locale.sh to
# set locale environment in docker container.
