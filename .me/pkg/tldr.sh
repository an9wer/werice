ME_LIB_TLDR=${ME_LIB_DIR}/tldr
ME_BIN_TLDR=${ME_BIN_DIR}/tldr


# Installation
# -----------------------------------------------------------------------------
me_install_tldr() {
  [[ -d ${ME_LIB_TLDR} ]] && return 0

  me_info "start to install z..."
  git clone --depth 1 "https://github.com/raylee/tldr.git" ${ME_LIB_TLDR}

  if (( $? == 0 )); then
    ln -sf ${ME_LIB_TLDR}/tldr ${ME_BIN_TLDR}
  fi
}

me_uninstall_tldr() {
  printf "It'll remove:\n"
  printf "    (1): ${ME_BIN_TLDR}\n"
  printf "    (2): ${ME_LIB_TLDR}\n"
  printf "are you sure? (y/n): "

  local sure
  read -r sure
  if [[ "${sure}" =~ [Y/y] ]]; then
    rm ${ME_BIN_TLDR}
    rm -rf ${ME_LIB_TLDR}
    me_info "TLDR has been uninstalled :)"
  fi
}

me_unset_tldr() {
  unset -v ME_LIB_TLDR ME_BIN_TLDR
  unset -f me_install_tldr me_uninstall_tldr me_unset_tldr
}
