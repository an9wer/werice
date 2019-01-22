#!/usr/bin/env bash

# thx: https://wiki.archlinux.org/index.php/locale

[[ -f /etc/locale.gen ]] && cp /etc/locale.gen{,.bak}
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

[[ -f /etc/locale.conf ]] && cp /etc/locale.conf{,.bak}
echo "LANG=en_US.UTF-8" > /etc/locale.conf

#
# To set locale environment in docker container, run the command:
#     . /etc/profile.d/locale.sh
#
