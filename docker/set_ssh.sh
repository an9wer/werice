#!/usr/bin/env bash

# thx: https://github.com/retorillo/archlinux-sshd/blob/master/Dockerfile

{
  # install depedence
  pacman -Sy --needed --noconfirm openssh
} && {
  # config ssh
  SSHD_CONFIG="/etc/ssh/sshd_config"
  [[ -f /etc/ssh/sshd_config ]] && cp ${SSHD_CONFIG} ${SSHD_CONFIG}.bak
  {
    echo "PermitRootLogin yes"
    echo "PasswordAuthentication yes"
  } >> ${SSHD_CONFIG}
} && {
  # startup ssh
  [[ ! -f /etc/ssh/ssh_host_rsa_key ]] && ssh-keygen -A
  /bin/sshd
}
