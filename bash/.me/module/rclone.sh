ME_LIB_RCLONE=${ME_LIB_DIR}/rclone
ME_BIN_RCLONE=${ME_BIN_DIR}/rclone
ME_MAN_RCLONE=${ME_MAN_DIR}/man1/rclone.1


# installation (thx: https://rclone.org/install.sh)
# -----------------------------------------------------------------------------
me_install_rclone() {
  if [[ -d ${ME_LIB_RCLONE} ]]; then
    if [[ ! -L ${ME_BIN_DIR}/rclone ]]; then
      ln -sf ${ME_LIB_RCLONE}/rclone ${ME_BIN_RCLONE}
    fi
    if [[ ! -L ${ME_MAN_DIR} ]]; then
      ln -sf ${ME_LIB_RCLONE}/rclone.1 ${ME_MAN_RCLONE}
    fi
    return 0
  fi

  me prompt "start to install rclone..."

  # detect the platform (only in linux)
  local ME_MACHINE=$(uname -m)
  case $ME_MACHINE in
    x86_64|amd64) ME_MACHINE=amd64;;
    i?86|x86) ME_MACHINE=386;;
    arm*) ME_MACHINE=arm;;
    *) me warn "cannnot install rclone (check your machine)"; return 1;;
  esac

  # create temporary file
  local zip_file=$(mktemp -t --suffix='.zip' rclone.XXX)
  local unzip_dir=$(mktemp -t -d rclone.XXX)

  # download rclone zip file
  curl https://downloads.rclone.org/rclone-current-linux-${ME_MACHINE}.zip -o ${zip_file}

  if (( $? == 0 )); then
    # extract rclone zip file and move it into 'lib' directory
    unzip ${zip_file} -d ${unzip_dir} &> /dev/null
    mv ${unzip_dir}/rclone-*-linux-${ME_MACHINE} ${ME_LIB_RCLONE}

    chmod 755 ${ME_LIB_DIR}/rclone/rclone
    ln -sf "${ME_LIB_RCLONE}/rclone" ${ME_BIN_RCLONE}
    ln -sf ${ME_LIB_RCLONE}/rclone.1 ${ME_MAN_RCLONE}
    mandb &> /dev/null
  fi
}

me_uninstall_rclone() {
  printf "It'll remove:\n"
  printf "    (1): ${ME_BIN_RCLONE}\n"
  printf "    (2): ${ME_MAN_RCLONE}\n"
  printf "    (3): ${ME_LIB_RCLONE}\n"
  printf "are you sure? (y/n): "

  local sure
  read -r sure
  if [[ "${sure}" == "y" ]]; then
    rm ${ME_BIN_RCLONE}
    rm ${ME_MAN_RCLONE} && mandb &> /dev/null
    rm -rf ${ME_LIB_RCLONE}
  fi
}

me_unset_rclone() {
  unset -v ME_LIB_RCLONE ME_BIN_RCLONE ME_MAN_RCLONE
  unset -f me_install_rclone me_uninstall_rclone me_unset_rlone rclone
}


# usage
# -----------------------------------------------------------------------------
rclone() {
  http_proxy="http://127.0.0.1:1080/"  \
  https_proxy="http://127.0.0.1:1080/" \
  no_proxy="localhost,127.0.0.0/8,::1" \
    command rclone $@
}

declare -fx rclone
