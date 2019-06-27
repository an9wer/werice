# Q: Vim displays wrong colors in tmux?
# A: https://askubuntu.com/a/133623

if ps -p $PPID -o comm= | grep -Eq '^tmux'; then
  export TERM=screen-256color
fi

