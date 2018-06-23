# thx: https://github.com/retorillo/archlinux-sshd/blob/master/Dockerfile

install_ssh() {
  pacman -Sy --noconfirm openssh
}

config_ssh() {
  local SSHD_CONFIG="/etc/ssh/sshd_config"
  [[ -f /etc/ssh/sshd_config ]] && cp ${SSHD_CONFIG} ${SSHD_CONFIG}.bak
  {
    echo "PermitRootLogin yes"
    echo "PasswordAuthentication yes"
  } >> ${SSHD_CONFIG}
}

startup_ssh() {
  [[ ! -f /etc/ssh/ssh_host_rsa_key ]] && ssh-keygen -A
  /bin/sshd
}

install_ssh && config_ssh && startup_ssh
