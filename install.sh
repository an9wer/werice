#!/usr/bin/env bash

DIR=$(cd $(dirname $0) && pwd)

declare -A PROGRAMS=(
  [xinitrc]="
    config .xinitrc"
  [xmodmap]="
    config_xmodmap
      && xmodmap ~/.xmodmaprc"
  [bashrc]="
    config .bashrc
      && echo Please run the command 'source ~/.bashrc'."
  [bash_profile]="
    config_bash_profile"
  [info]="
    config .infokey"
  [vim]="
    config .vimrc .vim
      && post_vim"
  [tmux]="
    config .tmux.conf"
  [git]="
    config .gitconfig .git-extensions"
  [gpg]="
    config .gnupg/gpg.conf .gnupg/dirmngr.conf .gnupg/sks-keyserver.netCA.pem"
  [dunst]="
    config .config/dunst
      && post_dunst"
  #[w3m]="config .w3m/keymap"
  #[dwm]="config_suckless dwm"
  #[st]="config_suckless st"
  #[slstatus]="config_suckless slstatus"
  #[dmenu]="config_suckless dmenu"
  #[slock]="config_suckless slock"
  #[pam]="config_pam_environment"
)

_backup() {
  # :param $1: file to be backed up

  # When file doesn't exist
  [[ -e "${1}" ]] || { echo "Create new file '$1'"; return; }
  # When file is a symbolic link
  [[ -h "${1}" ]] && { rm -vf "$1"; return; }

  local backup
  read -e -p "Do you want to backup original configuration files? (y/n): " backup
  [[ ${backup} =~ [Nn] ]] && return

  local dotbak
  local suffix=0
  
  for dotbak in $(ls ${1}.bak.[0-9] ${1}.bak.[1-9][0-9]* 2>/dev/null); do
    (( suffix < ${dotbak##*.} )) && suffix=${dotbak##*.}
    # Compare them only when they are regular files
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

  [[ -f $1 ]] || return

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

#config_bashrc() {
#  _read_cmdlines ~/.bashrc
#
#  cmdlines+=(
#    '# werice start {{{'
#    '[[ -f ~/.me/merc ]] && . ~/.me/merc'
#    '# }}} werice end'
#  )
#
#  #[[ ${backup} =~ [Nn] ]] || _backup ~/.me
#  _backup ~/.me
#  ln -vsf ${DIR}/.me ~/.me
#
#  [[ "${cmdlines[*]}" == "${cmdlines_old[*]}" ]] && return
#  #[[ ${backup} =~ [Nn] ]] || _backup ~/.bashrc
#  _backup ~/.bashrc
#  _write_cmdlines ~/.bashrc
#}

config_bash_profile() {
  _read_cmdlines ~/.bash_profile

  cmdlines+=(
    '# werice start {{{'
    'export GTK_IM_MODULE=fcitx'
    'export QT_IM_MODULE=fcitx'
    '[[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] && startx'
    '# }}} werice end'
  )

  #[[ ${backup} =~ [Nn] ]] || _backup ~/.bash_profile
  _backup ~/.bash_profile
  _write_cmdlines ~/.bash_profile
}

config_pam_environment() {
  _read_cmdlines ~/.pam_environment

  cmdlines+=(
    '# werice start {{{'
    'GTK_IM_MODULE=fcitx'
    'QT_IM_MODULE=fcitx'
    'XMODIFIERS=@im=fcitx'
    '# }}} werice end'
  )

  #[[ ${backup} =~ [Nn] ]] || _backup ~/.pam_environment
  _backup ~/.pam_environment
  _write_cmdlines ~/.pam_environment
}

config_xmodmap() {
  local choice
  cat <<EOF
1. Rapoo V500
2. HP EliteBook 8470p
3. ACER TravelMate TX50
EOF
  read -e -p "Which keyboard do you want to set? (1/2/3): " choice
  case $choice in
    1) ln -sf ${DIR}/xmodmap/Rapoo_V500.xmodmaprc ~/.xmodmaprc ;;
    2) ln -sf ${DIR}/xmodmap/HP_EliteBook_8470p.xmodmaprc ~/.xmodmaprc ;;
    3) ln -sf ${DIR}/xmodmap/ACER_TravelMate_TX50.xmodmaprc ~/.xmodmaprc ;;
    *) echo "Unknown option." ;;
  esac
}

#config_suckless() {
#  # :param $1: suckless module to be installed
#
#  [[ -h ~/.suckless ]] || ln -sf ${DIR}/suckless ~/.suckless
#  [[ $(hostname) =~ ^peace|cheese$ ]] || {
#    echo "Unkonwn host (only support peace or cheese)."
#    exit 1
#  }
#
#  local MOD_DIR=${DIR}/suckless/$1
#  git submodule update --init $MOD_DIR
#
#  set -i
#  cd ${MOD_DIR}
#  git stash
#  patch -b -o config.h config.def.h \
#    $MOD_DIR-patches/$1-config$(hostname)-*-$(git rev-parse --short HEAD).diff
#  git apply \
#    $MOD_DIR-patches/$1-custom-*-$(git rev-parse --short HEAD).diff
#  make && sudo make install && make clean
#  cd ${DIR}
#}

config() {
  # :param $@: configuration file to be installed

  for file in ${@}; do
    mkdir -pv $(dirname ${file})
    #[[ ${backup} =~ [Nn] ]] || _backup ~/${file}
    _backup ~/"$file"
    ln -vsf ${DIR}/${file} ~/${file}
  done
}

post_vim() {
  # vim bundle
  vim -e -c "call Bundle('install') | visual | qa"
}

post_dunst() {
  systemctl --user import-environment DISPLAY
  systemctl --user start dunst
  systemctl --user enable dunst
}


# Main
cat <<EOF
                       === rice installation ===
This script is intend to install configuration files for the following programs:
${!PROGRAMS[*]}
EOF
read -e -p "Which configuration file of program do you want to install? : " choice
echo ""

if [[ $choice =~ $(IFS='|'; echo "${!PROGRAMS[*]}") ]]; then
  eval "${PROGRAMS[$choice]}"
else
  echo "Unknown choice of configuration files :("
fi
