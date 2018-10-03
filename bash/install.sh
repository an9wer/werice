#!/usr/bin/env bash

DIR=$(cd $(dirname $0) && pwd)

declare -A CONFIG=(
  [3]=".me"
  [4]=".vimrc .vim"
  [5]=".tmux.conf"
  [6]=".gitconfig"
)

_config_write_cmdline() {
  # $1: file to save cmdline

  for line in "${cmdlines[@]}"; do
    if [ -e ${1} ]; then
      [[ -z $(grep "${line}" ${1}) ]] && echo "${line}" >> ${1}
    else
      echo "${line}" >> ${1}
    fi
  done
}

config_bashrc() {
  # $1: whether to backup bashrc

  file=~/.bashrc
  cmdlines=(
    '[[ -d ~/.me ]] && . ~/.me/main.sh'
  )

  if [[ -e ${file} ]]; then
    [[ ${1} =~ [nN] ]] || cp -vf ${file} ${file}.bak
  fi
  _config_write_cmdline ${file}
}

config_bash_profile() {
  # $1: whether to backup bashrc

  file=~/.bash_profile
  cmdlines=(
    'export GTK_IM_MODULE=fcitx'
    'export QT_IM_MODULE=fcitx'
    '[[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] && startx'
  )

  if [[ -e ~/.bash_profile ]]; then
    [[ ${1} =~ [nN] ]] || cp -vf ${file} ${file}.bak
  fi
  _config_write_cmdline ${file}
}

config() {
  # $1: which configuration to install
  # $2: whether to backup configrations


  (( ${1} == 1 )) && { config_bashrc $2; return; }
  (( ${1} == 2 )) && { config_bash_profile $2; return; }
  [[ -z ${CONFIG[${1}]} ]] && { echo unknown choice; exit 1; }

  for c in ${CONFIG[${1}]}; do
    if [[ -f ~/${c} ]]; then
      [[ ${2} =~ [nN] ]] && rm -vf ~/${c} || mv -vf ~/${c} ~/${c}.bak
    elif [[ -h ~/${c} ]]; then
      rm -vf ~/${c}
    fi
    ln -vsf ${DIR}/${c} ~/${c}
  done
}


[[ -d ~/.config ]] || mkdir ~/.config
cat <<EOF
                       === rice installation ===
This script is intend to install configuration files for the following programs.
  0. all
  1. bashrc
  2. bash_profile
  3. me
  4. vim
  5. tmux
  6. git
EOF
read -p "Let me known what is your choice: " choice
read -p "Do you want to backup your original configurations?(y/n): " backup

case ${choice} in
  0) for (( i = 1; i <= ${#CONFIG[@]}+2; i++ )); do config ${i} ${backup}; done ;;
  *) config ${choice} ${backup} ;;
esac

# vim bundle
#vim -e -c "call Bundle('install') | visual | qa"
