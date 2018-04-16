ME_LIB_ANSI_DIR=${ME_LIB_DIR}/ansi


# installation (thx: https://rclone.org/install.sh)
# -----------------------------------------------------------------------------
me::install_ansi() {
  if [[ ! -d ${ME_LIB_ANSI_DIR} ]]; then
    echo "start to install ansi..."
    git clone https://github.com/fidian/ansi.git ${ME_LIB_ANSI_DIR}
    chmod 755 ${ME_LIB_ANSI_DIR}/ansi
    ln -sf ${ME_LIB_ANSI_DIR}/ansi ${ME_BIN_DIR}/ansi
  fi
}

me::install_ansi


# usage
# -----------------------------------------------------------------------------
alias ansi="ansi -n"
