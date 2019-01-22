#!/usr/bin/env bash

# thx: https://wiki.archlinux.org/index.php/Time#Time_zone

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#[[ -f /etc/timezone ]] && cp /etc/timezone{,.bak}
#echo Asia/Shanghai > /etc/timezone
