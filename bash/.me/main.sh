#!/usr/bin/env bash

export ME_DIR=$(dirname ${BASH_SOURCE[0]})
export ME_BIN_DIR=${ME_DIR}/bin
export ME_MAN_DIR=${ME_DIR}/man
export ME_LIB_DIR=${ME_DIR}/lib
export ME_JOB_DIR=${ME_DIR}/job
export ME_MODULE_DIR=${ME_DIR}/module
export ME_BASHRC_DIR=${ME_DIR}/bashrc.d

export ME_ANSI_RED="\[\e[91m\]"
export ME_ANSI_BLUE="\[\e[94m\]"
export ME_ANSI_GREEN="\[\e[92m\]"
export ME_ANSI_YELLOW="\[\e[93m\]"
export ME_ANSI_MAGENTA="\[\e[95m\]"
export ME_ANSI_BOLD="\[\e[1m\]"
export ME_ANSI_END="\[\e[0m\]"


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
alias ll="ls -l"

alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

alias diff="diff --color=auto"

alias vimv="vim ~/.vimrc"
alias vimb="vim ~/.bashrc"
alias vimt="vim ~/.tmux.conf"
alias vimm="vim ~/.me/main.sh"
alias vimtest="vim --noplugin -N -u"

alias sourceb="source ~/.bashrc"

alias cdr="cd $(readlink -m ${ME_DIR}/../..)" # directory 'werice'
alias cdb="cd $(readlink -m ${ME_DIR}/..)"    # directory 'bash'
alias cdm="cd $(readlink -m ${ME_DIR})"       # directory 'me'

alias info="info --vi-keys"


# load function 'me'
source ${ME_LIB_DIR}/me.sh
source ${ME_LIB_DIR}/prompt.sh


# basic module
# -----------------------------------------------------------------------------


# say hello
command -v neofetch &> /dev/null && neofetch

# load custom bashrc
# -----------------------------------------------------------------------------
for bashrc in $(find ${ME_BASHRC_DIR} -name "*.sh"); do
  source ${bashrc}
done
