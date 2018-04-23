ME_LIB_JSON_DIR=${ME_LIB_DIR}/JSON


# installation
# -----------------------------------------------------------------------------
me::install_json() {
  if [[ ! -d $ME_LIB_JSON_DIR ]]; then
    echo "start to install JSON..."
    git clone "https://github.com/dominictarr/JSON.sh.git" ${ME_LIB_JSON_DIR}
    if (( $? == 0 )); then
      chmod 755 "${ME_LIB_JSON_DIR}/JSON.sh"
      ln -sf "${ME_LIB_JSON_DIR}/JSON.sh" "${ME_BIN_DIR}/JSON"
    fi
  fi
}

me::install_json
