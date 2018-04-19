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

export PATH="${PATH}:${ME_BIN_DIR}"
#export MANPATH=":${ME_MAN_DIR}"


# aliases
# -----------------------------------------------------------------------------
alias vimv="vim ~/.vimrc"
alias vimb="vim ~/.bashrc"
alias vimt="vim ~/.tmux.conf"

alias sourceb="source ~/.bashrc"

alias cdm="cd ${ME_DIR}"


# load function 'me'
source ${ME_LIB_DIR}/me.sh

# add basic module
# -----------------------------------------------------------------------------
me addm ansi


# funny cowsay
if command -v fortune &> /dev/null && command -v cowsay &> /dev/null; then
  fortune | cowsay
fi

# load custom bashrc
# -----------------------------------------------------------------------------
for bashrc in $(find ${ME_BASHRC_DIR} -name "*.sh"); do
  source ${bashrc}
done
