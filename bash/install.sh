#!/usr/bin/env bash

DIR=$(cd $(dirname $0) && pwd)

declare -A CONFIG_FUNC=(
  [1]="config_bashrc"
  [2]="config_bash_profile"
  [3]="config .vimrc .vim"
  [4]="config .tmux.conf"
  [5]="config .gitconfig"
)

declare -A CONFIG_CB=(
  [1]=""
  [2]=""
  [3]="callback_vim"
  [4]=""
  [5]=""
)

_backup() {
  # $1: file to backup
  # Note: It'll remove origin file.

  [[ -e "${1}" ]] || return
  [[ -h "${1}" ]] && rm -vf "$1" && return

  local backup_file
  local suffix=0
  
  for backup_file in $(ls ${1}.bak.[0-9] ${1}.bak.[0-9]+ 2>/dev/null); do
    (( suffix < ${backup_file##*.} )) && suffix=${backup_file##*.}
    [[ -f "${1}" && -f "${backup_file}" ]] && {
      cmp --silent "${1}" "${backup_file}" && rm -f "${backup_file}"
    }
  done

  [[ -f "${1}".bak.${suffix} ]] && suffix=$(( suffix + 1 ))
  mv -vf "${1}" "${1}".bak.${suffix}
}

_write_cmdlines() {
  # $1: file to write cmdline

  for line in "${cmdlines[@]}"; do
    echo "${line}" >> ${1}
  done
}

config_bashrc() {
  # $1: whether to backup bashrc

  cmdlines=()
  local pass=""
  while IFS='' read -r line || [[ -n "${line}" ]]; do
    [[ "${line}" =~ "werice start" ]] && { pass="y"; continue; }
    [[ "${line}" =~ "werice end" ]] && { pass=""; continue; }
    [[ -n "$pass" ]] && continue
    cmdlines+=("$line")
  done < ~/.bashrc

  cmdlines+=(
'# werice start {{{
[[ -d ~/.me ]] && . ~/.me/main.sh
# }}} werice end'
  )

  [[ ${1} =~ [Nn] ]] || _backup ~/.me
  ln -vsf ${DIR}/.me ~/.me

  [[ ${1} =~ [Nn] ]] || _backup ~/.bashrc
  _write_cmdlines ~/.bashrc
}

config_bash_profile() {
  # $1: whether to backup bashrc

  cmdlines=()
  local pass=""
  while IFS='' read -r line || [[ -n "${line}" ]]; do
    [[ "${line}" =~ "werice start" ]] && { pass="y"; continue; }
    [[ "${line}" =~ "werice end" ]] && { pass=""; continue; }
    [[ -n "$pass" ]] && continue
    cmdlines+=("$line")
  done < ~/.bash_profile

  cmdlines+=(
'# werice start {{{
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
[[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] && startx
# }}} werice end'
  )

  [[ ${1} =~ [Nn] ]] || _backup ~/.bash_profile
  _write_cmdlines ~/.bash_profile
}

config() {
  # $1 ... ${n-1}: which configuration file to install
  # $n: whether to backup configrations

  for file in ${@:1:${#@}-1}; do
    [[ ${@: -1} =~ [Nn] ]] || _backup ~/${file}
    ln -vsf ${DIR}/${file} ~/${file}
  done
}

callback_vim() {
  # vim bundle
  vim -e -c "call Bundle('install') | visual | qa"
}


# main
[[ -d ~/.config ]] || mkdir ~/.config
cat <<EOF
                       === rice installation ===
This script is intend to install configuration files for the following programs.
  0. all
  1. bashrc
  2. bash_profile
  3. vim
  4. tmux
  5. git
EOF
read -p "Let me known what is your choice: " choice
read -p "Do you want to backup your original configurations?(y/n): " backup

case ${choice} in
  0)
    for (( i = 1; i <= ${#CONFIG_FUNC[@]}; i++ )); do
      eval "${CONFIG_FUNC[${i}]} ${backup}"
      eval "${CONFIG_CB[${i}]}"
    done ;;
  *)
    if [[ -n ${CONFIG_FUNC[${choice}]} ]]; then
      eval "${CONFIG_FUNC[${choice}]} ${backup}"
      eval "${CONFIG_CB[${choice}]}"
    else
      echo unknown choice
      exit 1
    fi ;;
esac
