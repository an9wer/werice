ME_LIB_ANSI=${ME_LIB_DIR}/ansi
ME_BIN_ANSI=${ME_BIN_DIR}/ansi


# installation
# -----------------------------------------------------------------------------
me_install_ansi() {
  if [[ -d ${ME_LIB_ANSI} ]]; then
    [[ ! -L ${ME_BIN_DIR} ]] && ln -sf ${ME_LIB_ANSI}/ansi ${ME_BIN_ANSI}
    return 0
  fi

  me prompt "start to install ansi..."
  git clone "https://github.com/fidian/ansi.git" ${ME_LIB_ANSI}
  if (( $? == 0 )); then
    chmod 755 ${ME_LIB_ANSI}/ansi
    ln -sf ${ME_LIB_ANSI}/ansi ${ME_BIN_ANSI}
  fi
}

me_uninstall_ansi() {
  printf "It'll remove:\n"
  printf "    (1): ${ME_BIN_ANSI}\n"
  printf "    (2): ${ME_LIB_ANSI}\n"
  printf "are you sure? (y/n): "

  local sure
  read -r sure
  if [[ "${sure}" == "y" ]]; then
    rm  ${ME_BIN_ANSI}
    rm -rf ${ME_LIB_ANSI}
    unset -v ME_LIB_ANSI ME_BIN_ANSI
    unset -f me_install_ansi me_uninstall_ansi
    unalias ansi
    me prompt "ansi has been uninstalled :)"
  fi
}


# usage
# -----------------------------------------------------------------------------
alias ansi="ansi -n"
