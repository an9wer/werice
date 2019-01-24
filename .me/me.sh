#!/usr/bin/env bash

export ME_DIR=$(dirname ${BASH_SOURCE[0]})
export ME_BIN_DIR=${ME_DIR}/bin
export ME_MAN_DIR=${ME_DIR}/man
export ME_LIB_DIR=${ME_DIR}/lib
export ME_LOG_DIR=${ME_DIR}/log
export ME_CFG_DIR=${ME_DIR}/config
export ME_BASHRC_DIR=${ME_DIR}/bashrc.d
# Obsolete:
export ME_PKG_DIR=${ME_DIR}/pkg
export ME_JOB_DIR=${ME_DIR}/job


export ME_ANSI_END="\e[0m"
export ME_ANSI_BOLD="\e[1m"
export ME_ANSI_RED="\e[91m"
export ME_ANSI_GREEN="\e[92m"
export ME_ANSI_YELLOW="\e[93m"
export ME_ANSI_BLUE="\e[94m"
export ME_ANSI_MAGENTA="\e[95m"
export ME_ANSI_CYAN="\e[96m"
export ME_ANSI_WHITE="\e[97m"

# Wrapping the format code in '\[' and '\]' can avoid prompt issues when
# scrolling command history.
# thx: https://superuser.com/a/980982
# thx: http://tldp.org/HOWTO/Bash-Prompt-HOWTO/nonprintingchars.html
export ME_PROMPT_END="\[\e[0m\]"
export ME_PROMPT_BOLD="\[\e[1m\]"
export ME_PROMPT_RED="\[\e[91m\]"
export ME_PROMPT_GREEN="\[\e[92m\]"
export ME_PROMPT_YELLOW="\[\e[93m\]"
export ME_PROMPT_BLUE="\[\e[94m\]"
export ME_PROMPT_MAGENTA="\[\e[95m\]"
export ME_PROMPT_CYAN="\[\e[96m\]"
export ME_PROMPT_WHITE="\[\e[97m\]"


# environment variable
# -----------------------------------------------------------------------------
export EDITOR=vim
export VISUAL=vim

# fc builtin editor
export FCEDIT=vim

# history
export HISTFILE=~/.bash_history
export HISTSIZE=        # unlimited
export HISTFILESIZE=    # unlimited
export HISTTIMEFORMAT="[%Y/%m/%d %T]  "
export HISTCONTROL=ignoredups
export HISTIGNORE="ls:ll:pwd:vim:history:git status"

[[ ! "${PATH}" =~ "${ME_BIN_DIR}" ]] && export PATH="${ME_BIN_DIR}:${PATH}"
[[ ! "${PATH}" =~ "${HOME}/.git-extensions" ]] && export PATH="${HOME}/.git-extensions:${PATH}"


# aliases
# -----------------------------------------------------------------------------
alias ls="ls --color=auto"
alias ll="ls -lh"
alias lsc="ls --color=always"
alias llc="ll --color=always"

alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

alias diff="diff --color=auto"

# Display colors when using less
# thx: https://superuser.com/a/275869
#alias less="less -R"

alias info="info --vi-keys"

alias sourceb="source ~/.bashrc"

alias cdr="cd $(readlink -m ${ME_DIR}/../..)" # directory 'werice'
alias cdb="cd $(readlink -m ${ME_DIR}/..)"    # directory 'bash'
alias cdm="cd $(readlink -m ${ME_DIR})"       # directory 'me'

alias vimv="vim ~/.vimrc"
alias vimb="vim ~/.bashrc"
alias vimt="vim ~/.tmux.conf"
alias vimm="vim ~/.me/me.sh"
alias vimtest="vim --noplugin -N -u"

alias todo="vim ~/Documents/notes/todo.wiki"

# virtual console
[[ $(tty) =~ /dev/tty ]] && {
  setfont Tamsyn10x20r &> /dev/null
  setterm --blength 0
}

# load libs
source ${ME_LIB_DIR}/base.sh
source ${ME_LIB_DIR}/package.sh


# basic module
# -----------------------------------------------------------------------------


# load custom bashrc
# -----------------------------------------------------------------------------
for bashrc in $(find ${ME_BASHRC_DIR} -name "*.sh"); do
  source ${bashrc}
done

# say hello
command -v neofetch &> /dev/null && neofetch
