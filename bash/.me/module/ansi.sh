ME_LIB_ANSI_DIR=${ME_LIB_DIR}/ansi


# installation (thx: https://rclone.org/install.sh)
# -----------------------------------------------------------------------------
me::install_ansi() {
  if [[ -d ${ME_LIB_ANSI_DIR} ]]; then
    if [[ ! -L ${ME_BIN_DIR}/ansi ]]; then
      ln -sf ${ME_LIB_ANSI_DIR}/ansi ${ME_BIN_DIR}/ansi
    fi
    return 0
  fi

  me prompt "start to install ansi..."
  git clone "https://github.com/fidian/ansi.git" ${ME_LIB_ANSI_DIR}
  if (( $? == 0 )); then
    chmod 755 ${ME_LIB_ANSI_DIR}/ansi
    ln -sf ${ME_LIB_ANSI_DIR}/ansi ${ME_BIN_DIR}/ansi
  fi
}

me::uninstall_ansi() {
  rm -i ${ME_BIN_DIR}/ansi
  rm -rI ${ME_LIB_ANSI_DIR}
}


# usage
# -----------------------------------------------------------------------------
alias ansi="ansi -n"
