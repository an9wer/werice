#!/usr/bin/env bash

export ME_DIR=$(dirname ${BASH_SOURCE[0]})
export ME_BIN_DIR=${ME_DIR}/bin
export ME_MAN_DIR=${ME_DIR}/man
export ME_LIB_DIR=${ME_DIR}/lib
export ME_JOB_DIR=${ME_DIR}/job
export ME_MODULE_DIR=${ME_DIR}/module
export ME_BASHRC_DIR=${ME_DIR}/bashrc.d


# environment variable
# -----------------------------------------------------------------------------
export FCEDIT=vi
export VISUAL=vi

# fc builtin editor
export EDITOR=vi

# history
export HISTFILE=~/.bash_history
export HISTSIZE=1000
export HISTFILESIZE=10000
export HISTTIMEFORMAT="%Y/%m/%d %T  "

if [[ ! "${PATH}" =~ "${ME_BIN_DIR}" ]]; then
  export PATH="${PATH}:${ME_BIN_DIR}"
fi
#export MANPATH=":${ME_MAN_DIR}"

# prompting
# need to wrap '\[' and '\]' to every color variable to avoid position issure
# (thx: https://superuser.com/a/980982)
BOLD="\[\e[1m\]" RED="\[\e[91m\]" GREEN="\[\e[92m\]" BLUE="\[\e[94m\]" YELLOW="\[\e[93m\]" END="\[\e[0m\]"
PS1="${YELLOW}┌─  ${BOLD}${GREEN}\u@\h${END} at ${BOLD}${RED}\t${END} in ${BOLD}${BLUE}\w${END}\n${YELLOW}└─▪ \$${END} "
PS2="${YELLOW}└─▪ > ${END}"
unset BOLD BLUE RED END


# aliases
# -----------------------------------------------------------------------------
alias ls="ls --color=auto"
alias ll="ls -l"

alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

alias vimv="vim ~/.vimrc"
alias vimb="vim ~/.bashrc"
alias vimt="vim ~/.tmux.conf"

alias sourceb="source ~/.bashrc"

alias cdm="cd ${ME_DIR}"

alias info="info --vi-keys"


# load function 'me'
source ${ME_LIB_DIR}/me.sh


# basic module
# -----------------------------------------------------------------------------


# funny cowsay
if command -v fortune &> /dev/null && command -v cowsay &> /dev/null; then
  fortune | cowsay
fi

# load custom bashrc
# -----------------------------------------------------------------------------
for bashrc in $(find ${ME_BASHRC_DIR} -name "*.sh"); do
  source ${bashrc}
done
