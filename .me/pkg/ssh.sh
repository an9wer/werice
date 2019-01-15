# Installation
# -----------------------------------------------------------------------------
me_unset_ssh() {
  unset -f me_unset_ssh sshh
}


# The hack way
# -----------------------------------------------------------------------------

export SSH_AGENT_RC=~/.ssh/.ssh-agent.rc
if [[ -z "$SSH_AGENT_PID" ]]; then
  if [[ -f $SSH_AGENT_RC &&
        $(sed -nr 's/echo Agent pid ([0-9]*);/\1/p' $SSH_AGENT_RC) \
          != $(pgrep -u "$USER" ssh-agent) ||
        ! (-f $SSH_AGENT_RC) ]] ; then
    pkill -u "$USER" ssh-agent
    ssh-agent > $SSH_AGENT_RC
  fi
  eval "$(<$SSH_AGENT_RC)" > /dev/null
fi

sshh() {
  grep -wi "Host" ~/.ssh/config | grep -wv "\*" | sed 's/Host//'
}
