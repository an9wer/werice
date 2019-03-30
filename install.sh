#!/usr/bin/env bash

DIR=$(cd $(dirname $0) && pwd)

declare -A CONFIG_FUNC=(
  [1]="config_bashrc"
  [2]="config_bash_profile"
  [3]="config .vimrc .vim"
  [4]="config .tmux.conf"
  [5]="config .gitconfig .git-extensions"
  [6]="config_xmodmap"
  [7]="config .gnupg/gpg.conf .gnupg/dirmngr.conf .gnupg/sks-keyserver.netCA.pem"
  [8]="config .w3m/keymap"
  [9]="config_suckless dwm"
  [10]="config_suckless st"
  [11]="config_suckless slstatus"
  [12]="config_suckless dmenu"
  [13]="config_suckless slock"
  [14]="config .config/dunst"
  [15]="config .xinitrc"
  [16]="config .infokey"
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
  [9]=""
  [10]=""
  [11]=""
  [12]=""
  [13]=""
  [14]=""
  [15]=""
  [16]=""
)

_backup() {
  # :param $1: file to be backed up

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
  # :param $1: file to be paresed to find cmdlines

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
  # :param $1: file to be written with cmdlines

  for line in "${cmdlines[@]}"; do
    echo "${line}"
  done > ${1}
}

config_bashrc() {
  _read_cmdlines ~/.bashrc

  cmdlines+=(
    '# werice start {{{'
    '[[ -d ~/.me ]] && . ~/.me/me.sh'
    '# }}} werice end'
  )

  [[ ${backup} =~ [Nn] ]] || _backup ~/.me
  ln -vsf ${DIR}/.me ~/.me

  [[ "${cmdlines[*]}" == "${cmdlines_old[*]}" ]] && return
  [[ ${backup} =~ [Nn] ]] || _backup ~/.bashrc
  _write_cmdlines ~/.bashrc
}

config_bash_profile() {
  _read_cmdlines ~/.bash_profile

  cmdlines+=(
    '# werice start {{{'
    'export GTK_IM_MODULE=fcitx'
    'export QT_IM_MODULE=fcitx'
    '[[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] && startx'
    '# }}} werice end'
  )

  [[ ${backup} =~ [Nn] ]] || _backup ~/.bash_profile
  _write_cmdlines ~/.bash_profile
}

config_xmodmap() {
  local choice
  cat <<EOF
1. Rapoo V500
2. HP EliteBook 8470p
3. ACER TravelMate TX50
EOF
  read -p "Which keyboard do you want to set? (1/2): " choice
  case $choice in
    1) ln -sf ${DIR}/xmodmap/Rapoo_V500.Xmodmap ~/.Xmodmap ;;
    2) ln -sf ${DIR}/xmodmap/HP_EliteBook_8470p.Xmodmap ~/.Xmodmap ;;
    3) ln -sf ${DIR}/xmodmap/ACER_TravelMate_TX50.Xmodmap ~/.Xmodmap ;;
    *) echo "Unknown option." ;;
  esac
}

config_suckless() {
  # :param $1: suckless module to be installed

  [[ -h ~/.suckless ]] || ln -sf ${DIR}/suckless ~/.suckless
  [[ $(hostname) =~ ^peace|cheese$ ]] || {
    echo "Unkonwn host (only support peace or cheese)."
    exit 1
  }

  local MOD_DIR=${DIR}/suckless/$1
  git submodule update --init $MOD_DIR

  set -i
  cd ${MOD_DIR}
  git stash
  patch -b -o config.h config.def.h \
    $MOD_DIR-patches/$1-config$(hostname)-*-$(git rev-parse --short HEAD).diff
  git apply \
    $MOD_DIR-patches/$1-custom-*-$(git rev-parse --short HEAD).diff
  make && sudo make install && make clean
  cd ${DIR}
}

config() {
  # :param $@: configuration file to be installed

  for file in ${@}; do
    mkdir -pv $(dirname ${file})
    [[ ${backup} =~ [Nn] ]] || _backup ~/${file}
    ln -vsf ${DIR}/${file} ~/${file}
  done
}

callback_vim() {
  # vim bundle
  vim -e -c "call Bundle('install') | visual | qa"
}


# Main
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
  8. w3m
  9. dwm
 10. st
 11. slstatus
 12. dmenu
 13. slock
 14. dunst
 15. xinitrc
 16. info
EOF
read -p "Which configuration file do you want to install? (0/1/.../${#CONFIG_FUNC[@]}): " choice
read -p "Do you want to backup your original configurations? (y/n): " backup
echo ""

case ${choice} in
  0)
    for (( i = 1; i <= ${#CONFIG_FUNC[@]}; i++ )); do
      eval "${CONFIG_FUNC[${i}]}"
      eval "${CONFIG_CB[${i}]}"
    done ;;
  *)
    if [[ -n ${CONFIG_FUNC[${choice}]} ]]; then
      eval "${CONFIG_FUNC[${choice}]}"
      eval "${CONFIG_CB[${choice}]}"
    else
      echo "Unknown choice of configuration files :("
      exit 1
    fi ;;
esac

