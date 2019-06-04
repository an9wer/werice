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

sshrc() {
  files="alias.sh history.sh prompt.sh trash.sh editor.sh less.sh"

  ssh -t "$@" "
    command -v openssl &>/dev/null || { echo >&2 \"sshrc requires openssl to be installed on the server, but it's not. Aborting.\"; exit 1; }
    export SSHRC=\$(mktemp -d -t .$(whoami).sshrc.XXXX)
    echo $'"$(tar czf - -C ~/.me/bashrc.d $files | openssl enc -base64)"' |  tr -s ' ' $'\n' | openssl enc -base64 -d | tar mxzf - -C \$SSHRC
    bash --rcfile <(echo '
      [ -r /etc/profile ] && source /etc/profile
      if [ -r ~/.bash_profile ]; then source ~/.bash_profile
      elif [ -r ~/.bash_login ]; then source ~/.bash_login
      elif [ -r ~/.profile ]; then source ~/.profile
      fi
      for rc in $files; do source \$SSHRC/\$rc; done
    ')
  "
}

