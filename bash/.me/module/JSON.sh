ME_LIB_JSON=${ME_LIB_DIR}/JSON
ME_BIN_JSON=${ME_BIN_DIR}/JSON


# installation
# -----------------------------------------------------------------------------
me_install_JSON() {
  if which JSON &> /dev/null; then
    me prompt "JSON has been installed :)"
    return 0
  fi

  if [[ -d $ME_LIB_JSON ]]; then
    if [[ ! -L ${ME_BIN_JSON} ]]; then
      ln -sf "${ME_LIB_JSON}/JSON.sh" "${ME_BIN_JSON}"
    fi
    return 0
  fi
    
  me prompt "start to install JSON..."
  git clone "https://github.com/dominictarr/JSON.sh.git" ${ME_LIB_JSON}
  if (( $? == 0 )); then
    chmod 755 "${ME_LIB_JSON}/JSON.sh"
    ln -sf "${ME_LIB_JSON}/JSON.sh" "${ME_BIN_JSON}"
  fi
}

me_uninstall_JSON() {
  if ! which JSON &> /dev/null; then
    me warn "JSON hasn't been installed :("
    return 1
  fi

  if [[ ! $(which JSON) == ${ME_BIN_JSON} ]]; then
    me warn "JSON may be installed by your system package manager."
    return 1
  fi

  printf "It'll remove:\n"
  printf "    (1): ${ME_BIN_JSON}\n"
  printf "    (2): ${ME_LIB_JSON}\n"
  printf "are you sure? (y/n): "

  local sure
  read -r sure
  if [[ "${sure}" == "y" ]]; then
    rm ${ME_BIN_JSON}
    rm -rf ${ME_LIB_JSON}
    unset -v ME_LIB_JSON ME_BIN_JSON
    unset -f me_install_JSON me_uninstall_JSON
    me prompt "JSON has been uninstalled :)"
  fi
}
