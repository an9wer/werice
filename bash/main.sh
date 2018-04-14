#!/usr/bin/env bash

DIR=$(dirname ${BASH_SOURCE[0]})
LIB_DIR=${DIR}/lib
CUSTOM_DIR=${DIR}/custom


# environment variable
# -----------------------------------------------------------------------------
FCEDIT=vi
VISUAL=vi

# fc builtin editor
EDITOR=vi

# history
HISTFILE=~/.bash_history
HISTSIZE=1000
HISTFILESIZE=10000
HISTTIMEFORMAT="%Y/%m/%d %T  "


# aliases
# -----------------------------------------------------------------------------
alias vimv="vim ~/.vimrc"
alias vimb="vim ~/.bashrc"

alias sourceb="source ~/.bashrc"


# function
# -----------------------------------------------------------------------------

# create links to 'lib' directory scripts in 'custom' directory
adds() {
  for script_name in $@; do
    if [[ -e ${LIB_DIR}/${script_name}.sh ]]; then
      ln -sf ${LIB_DIR}/${script_name}.sh ${CUSTOM_DIR}/${script_name}.sh
      source ${CUSTOM_DIR}/${script_name}.sh
    else
      echo "${script_name} doesn't exist in lib directory."
    fi
  done
}

# remove links in 'custom' directory
dels() {
  for script_name in $@; do
    if [[ -L ${CUSTOM_DIR}/${script_name}.sh ]]; then
      rm -i ${CUSTOM_DIR}/${script_name}.sh
    else
      echo "${script_name} doesn't exist or can't be removed (not a symbolic file)."
    fi
  done
}


# load custom scripts
# -----------------------------------------------------------------------------
for script_file in $(find ${CUSTOM_DIR} -name "*.sh"); do
  source ${script_file}
done
