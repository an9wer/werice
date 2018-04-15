sshh() {
  grep -w -i "Host" ~/.ssh/config | sed 's/Host//'
}
