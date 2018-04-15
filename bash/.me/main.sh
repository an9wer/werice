#!/usr/bin/env bash

ME_DIR=$(dirname ${BASH_SOURCE[0]})
ME_BIN_DIR=${ME_DIR}/bin
ME_MAN_DIR=${ME_DIR}/man
ME_LIB_DIR=${ME_DIR}/lib
ME_MODULE_DIR=${ME_DIR}/module
ME_BASHRC_DIR=${ME_DIR}/bashrc.d


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

alias sourceb="source ~/.bashrc"
alias csb="cd ${ME_BASHRC_DIR}"


source ${ME_LIB_DIR}/me.sh


# load custom bashrc
# -----------------------------------------------------------------------------
for bashrc in $(find ${ME_BASHRC_DIR} -name "*.sh"); do
  source ${bashrc}
done
