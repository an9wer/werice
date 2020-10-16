alias sourceb="source ~/.bashrc"

# vim
alias vimtest="vim --noplugin -N -u"
alias viblog="vim ~/Documents/blog/bookmark.txt"

# ls
alias ls="ls --color=auto"
alias ll="ls -lh"
alias lsc="ls --color=always"
alias llc="ll --color=always"

# grep
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias grepc="grep --color=always"
alias egrepc="egrep --color=always"
alias fgrepc="fgrep --color=always"

# diff
alias diff="diff --color=auto"

# date
alias dt="date '+%Y/%m/%d'"
alias dtw="date '+%Y/%m/%d %a'"
alias dts="date '+%s'"

# xclip
alias xcp="xclip -r -selection clipboard"
alias xcplc="fc -ln -1 | tee $(tty) | xargs | xclip -r -selection clipboard"
