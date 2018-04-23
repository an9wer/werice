ME_LIB_AUTOSSH_DIR=${ME_LIB_DIR}/autossh


# installation
# -----------------------------------------------------------------------------
me::install_autossh() {
  if [[ -d ${ME_LIB_AUTOSSH_DIR} ]]; then
    return
  fi

  local temp_dir=$(mktemp -d -t autossh.XXX)
  wget "http://www.harding.motd.ca/autossh/autossh-1.4f.tgz" -P ${temp_dir}
  if (( $? == 0 )); then
    tar -zxf "${temp_dir}/autossh-1.4f.tgz" -C ${temp_dir}
    local curr_dir=$(pwd)
    cd ${temp_dir}/autossh-1.4f
    ./configure --prefix=${ME_LIB_AUTOSSH_DIR} && make && make install
    if (( $? == 0 )); then
      ln -sf ${ME_LIB_AUTOSSH_DIR}/autossh/bin/autossh ${ME_BIN_DIR}/autossh
      ln -sf ${ME_LIB_AUTOSSH_DIR}/man/man1/autossh.1 ${ME_MAN_DIR}/man1/autossh.1
      mandb &> /dev/null
    fi
    cd ${curr_dir}
  fi
}

me::install_autossh
