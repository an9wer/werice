export HISTFILE="$HOME/.bash_history"
export HISTSIZE=-1      # unlimited
export HISTFILESIZE=-1  # unlimited
export HISTTIMEFORMAT="[%Y/%m/%d %T]  "
export HISTCONTROL=ignoredups
export HISTIGNORE="ls:pwd:vim:history:git status:xcplc"

shopt -s histappend
