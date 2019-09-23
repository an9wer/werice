export HISTFILE="$HOME/.bash_history"
export HISTSIZE=-1      # unlimited
export HISTFILESIZE=-1  # unlimited
export HISTTIMEFORMAT="[%Y/%m/%d %T]  "
export HISTCONTROL=ignoredups
export HISTIGNORE="ls:ll:pwd:vim:history:man *:info *:help *:git status"

shopt -s histappend
