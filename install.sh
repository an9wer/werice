#!/usr/bin/env bash

DIR=$(cd $(dirname $0) && pwd)

declare -A CONFIG_FUNC=(
  [1]="config_bashrc"
  [2]="config_bash_profile"
  [3]="config .vimrc .vim"
  [4]="config .tmux.conf"
  [5]="config .gitconfig"
  [6]="config_xmodmap"
  [7]="config .gnupg/gpg.conf"
  [8]="config_suckless dwm"
)

declare -A CONFIG_CB=(
  [1]="echo Please run the command \'source \~/.bashrc\'"
  [2]=""
  [3]="callback_vim"
  [4]=""
  [5]=""
  [6]="xmodmap ~/.Xmodmap"
  [7]=""
  [8]=""
)

_backup() {
  # $1: file to backup

  [[ -e "${1}" ]] || return
  [[ -h "${1}" ]] && rm -vf "$1" && return

  local dotbak
  local suffix=0
  
  for dotbak in $(ls ${1}.bak.[0-9] ${1}.bak.[1-9][0-9]* 2>/dev/null); do
    (( suffix < ${dotbak##*.} )) && suffix=${dotbak##*.}
    # compare only when they are regular files
    [[ -f "${1}" && -f "${dotbak}" ]] && {
      cmp --silent "${1}" "${dotbak}" && rm -f "${dotbak}"
    }
  done

  [[ -e "${1}".bak.${suffix} ]] && suffix=$(( suffix + 1 ))
  mv -vf "${1}" "${1}".bak.${suffix}
}

_read_cmdlines() {
  # $1: file to read cmdlines
  cmdlines=()
  cmdlines_old=()
  local pass=""
  while IFS='' read -r line || [[ -n "${line}" ]]; do
    cmdlines_old+=("$line")
    [[ "${line}" =~ "werice start" ]] && { pass="y"; continue; }
    [[ "${line}" =~ "werice end" ]] && { pass=""; continue; }
    [[ -n "$pass" ]] && continue
    cmdlines+=("$line")
  done < "${1}"
}

_write_cmdlines() {
  # $1: file to write cmdlines

  for line in "${cmdlines[@]}"; do
    echo "${line}"
  done > ${1}
}

config_bashrc() {
  # $1: whether to backup bashrc

  _read_cmdlines ~/.bashrc

  cmdlines+=(
    '# werice start {{{'
    '[[ -d ~/.me ]] && . ~/.me/me.sh'
    '# }}} werice end'
  )

  [[ ${1} =~ [Nn] ]] || _backup ~/.me
  ln -vsf ${DIR}/.me ~/.me

  [[ "${cmdlines[*]}" == "${cmdlines_old[*]}" ]] && return
  [[ ${1} =~ [Nn] ]] || _backup ~/.bashrc
  _write_cmdlines ~/.bashrc
}

config_bash_profile() {
  # $1: whether to backup bashrc

  _read_cmdlines ~/.bash_profile

  cmdlines+=(
    '# werice start {{{'
    'export GTK_IM_MODULE=fcitx'
    'export QT_IM_MODULE=fcitx'
    '[[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] && startx"'
    '# }}} werice end'
  )

  [[ ${1} =~ [Nn] ]] || _backup ~/.bash_profile
  _write_cmdlines ~/.bash_profile
}

config_xmodmap() {
  local choice
  cat <<EOF
1. HP EliteBook 8470p
2. Rapoo V500
EOF
  read -p "Which keyboard do you want to set? (1/2): " choice
  case $choice in
    1) ln -sf ${DIR}/xmodmap/HP_EliteBook_8470p.Xmodmap ~/.Xmodmap ;;
    2) ln -sf ${DIR}/xmodmap/Rapoo_V500.Xmodmap ~/.Xmodmap ;;
    *) echo "Unknown keyboard :(" ;;
  esac
}

config_suckless() {
  # $1: which suckless module to config

  [[ -h ~/.suckless ]] || ln -sf ${DIR}/suckless ~/.suckless

  local MOD_DIR=~/.suckless/$1
  git submodule update $MOD_DIR

  cd ${MOD_DIR}
  patch -o config.h config.def.h $MOD_DIR-patches/dwm-config-*-$(git rev-parse --short HEAD).diff
  make && sudo make install
}

config_dwm() {
  git submodule update ${DIR}/suckless/dwm
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
cat <<EOF
                       === rice installation ===
This script is intend to install configuration files for the following programs.
  0. all
  1. bashrc
  2. bash_profile
  3. vim
  4. tmux
  5. git
  6. xmodmap
  7. gpg
  8. dwm
EOF
read -p "Which configuration file do you want to install? (0/1/.../${#CONFIG_FUNC[@]}): " choice
read -p "Do you want to backup your original configurations? (y/n): " backup
echo ""

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
      echo "Unknown choice of configuration files :("
      exit 1
    fi ;;
esac
