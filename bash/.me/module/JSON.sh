ME_LIB_JSON_DIR=${ME_LIB_DIR}/JSON


# installation
# -----------------------------------------------------------------------------
me::install_JSON() {
  if [[ -d $ME_LIB_JSON_DIR ]]; then
    if [[ ! -L ${ME_BIN_DIR}/JSON ]]; then
      ln -sf "${ME_LIB_JSON_DIR}/JSON.sh" "${ME_BIN_DIR}/JSON"
    fi
    return 0
  fi
    
  ansi:prompt "start to install JSON..."
  git clone "https://github.com/dominictarr/JSON.sh.git" ${ME_LIB_JSON_DIR}
  if (( $? == 0 )); then
    chmod 755 "${ME_LIB_JSON_DIR}/JSON.sh"
    ln -sf "${ME_LIB_JSON_DIR}/JSON.sh" "${ME_BIN_DIR}/JSON"
  fi
}

me::uninstall_JSON() {
  rm -i ${ME_BIN_DIR}/JSON
  rm -rI ${ME_LIB_JSON_DIR}
}
