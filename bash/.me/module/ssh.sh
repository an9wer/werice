# installation
# -----------------------------------------------------------------------------
me_unset_ssh() {
  unset -f me_unset_ssh sshh
}


# usage
# -----------------------------------------------------------------------------
sshh() {
  grep -wi "Host" ~/.ssh/config | grep -wv "\*" | sed 's/Host//'
}
