# installation
# -----------------------------------------------------------------------------
me_unset_ssh() {
  unset -f me_unset_ssh sshh
}


# usage
# -----------------------------------------------------------------------------
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  ssh-agent > ~/.ssh-agent.rc
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
  eval "$(<~/.ssh-agent.rc)"
fi

sshh() {
  grep -wi "Host" ~/.ssh/config | grep -wv "\*" | sed 's/Host//'
}
