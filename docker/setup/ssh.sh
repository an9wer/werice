#!/usr/bin/env bash

# thx: https://github.com/retorillo/archlinux-sshd/blob/master/Dockerfile

{ # Install dependences
  pacman -Sy --needed --noconfirm openssh

} && { # Config ssh
  SSHD_CONFIG="/etc/ssh/sshd_config"
  [[ -f /etc/ssh/sshd_config ]] && cp ${SSHD_CONFIG}{,.bak}
  {
    echo "PermitRootLogin yes"
    echo "PasswordAuthentication yes"
  } >> ${SSHD_CONFIG}

} && { # Setup ssh
  [[ ! -f /etc/ssh/ssh_host_rsa_key ]] && ssh-keygen -A
  /bin/sshd

}
