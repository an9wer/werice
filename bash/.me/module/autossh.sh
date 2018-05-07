ME_LIB_AUTOSSH=${ME_LIB_DIR}/autossh
ME_BIN_AUTOSSH=${ME_BIN_DIR}/autossh
ME_MAN_AUTOSSH=${ME_MAN_DIR}/man1/autossh.1


# installation
# -----------------------------------------------------------------------------
me_install_autossh() {
  if which autossh &> /dev/null; then
    me prompt "autossh has been installed :)"
    return 0
  fi

  if [[ -d ${ME_LIB_AUTOSSH} ]]; then
    echo ${ME_BIN_AUTOSSH}
    if [[ ! -L ${ME_BIN_AUTOSSH} ]]; then
      echo 1
      ln -sf ${ME_LIB_AUTOSSH}/bin/autossh ${ME_BIN_AUTOSSH}
    fi
    if [[ ! -L ${ME_MAN_AUTOSSH} ]]; then
      echo 2
      ln -sf ${ME_LIB_AUTOSSH}/man/man1/autossh.1 ${ME_MAN_AUTOSSH}
    fi
    echo 3
    return 0
  fi

  me prompt "start to install autossh..."
  local temp_dir=$(mktemp -d -t autossh.XXX)
  wget "http://www.harding.motd.ca/autossh/autossh-1.4f.tgz" -P ${temp_dir}
  if (( $? == 0 )); then
    tar -zxf "${temp_dir}/autossh-1.4f.tgz" -C ${temp_dir}
    local curr_dir=$(pwd)
    cd ${temp_dir}/autossh-1.4f
    ./configure --prefix=${ME_LIB_AUTOSSH} && make && make install
    if (( $? == 0 )); then
      ln -sf ${ME_LIB_AUTOSSH}/bin/autossh ${ME_BIN_AUTOSSH}
      ln -sf ${ME_LIB_AUTOSSH}/man/man1/autossh.1 ${ME_MAN_AUTOSSH}
      mandb &> /dev/null
    fi
    cd ${curr_dir}
  fi
}

me_uninstall_autossh() {
  if ! which autossh $> /dev/null; then
    me warn "autossh hasn't been installed :("
    return 1
  fi

  if [[ ! $(which autossh) == ${ME_BIN_AUTOSSH} ]]; then
    me warn "autossh may be installed by your system package manager."
    return 1
  fi

  printf "It'll remove:\n"
  printf "    (1): ${ME_BIN_AUTOSSH}\n"
  printf "    (2): ${ME_MAN_AUTOSSH}\n"
  printf "    (3): ${ME_LIB_AUTOSSH}\n"
  printf "are you sure? (y/n): "

  local sure
  read -r sure
  if [[ "${sure}" == 'y' ]]; then
    rm ${ME_BIN_AUTOSSH}
    rm ${ME_MAN_AUTOSSH} && mandb $> /dev/null
    rm -r ${ME_LIB_AUTOSSH}
    unset -v ME_BIN_AUTOSSH ME_MAN_AUTOSSH ME_LIB_AUTOSSH
    unset -f me_install_autossh me_uninstall_autossh
    me prompt "autossh has been uninstalled :)"
  fi 
}
