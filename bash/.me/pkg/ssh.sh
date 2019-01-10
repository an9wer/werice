# Installation
# -----------------------------------------------------------------------------
me_unset_ssh() {
  unset -f me_unset_ssh sshh
}


# The hack way
# -----------------------------------------------------------------------------
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  ssh-agent > ~/.ssh/.ssh-agent.rc
  eval "$(<~/.ssh/.ssh-agent.rc)" > /dev/null
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
  eval "$(<~/.ssh/.ssh-agent.rc)" > /dev/null
fi

sshh() {
  grep -wi "Host" ~/.ssh/config | grep -wv "\*" | sed 's/Host//'
}
