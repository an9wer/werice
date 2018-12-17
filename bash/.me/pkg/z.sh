ME_LIB_Z=${ME_LIB_DIR}/z
ME_MAN_Z=${ME_MAN_DIR}/man1/z.1


# installation
# -----------------------------------------------------------------------------
me_install_z() {
  [[ -d ${ME_LIB_Z} ]] && return 0

  me_info "start to install z..."
  git clone --depth 1 "https://github.com/rupa/z.git" ${ME_LIB_Z}

  if (( $? == 0 )); then
    ln -sf ${ME_LIB_Z}/z.1 ${ME_MAN_Z}
    mandb &> /dev/null
  fi
}

me_uninstall_z() {
  printf "It'll remove:\n"
  printf "    (1): ${ME_MAN_Z}\n"
  printf "    (2): ${ME_LIB_Z}\n"
  printf "are you sure? (y/n): "

  local sure
  read -r sure
  if [[ "${sure}" =~ [Y/y] ]]; then
    rm ${ME_MAN_Z} && mandb $> /dev/null
    rm -rf ${ME_LIB_Z}
    me_info "z has been uninstalled :)"
  fi 
}

me_unset_z() {
  unset -v ME_MAN_Z ME_LIB_Z
  unset -f me_install_z me_uninstall_z me_unset_z
}

# usage
# -----------------------------------------------------------------------------
# source z.sh
[[ -f ${ME_LIB_Z}/z.sh ]] && source ${ME_LIB_Z}/z.sh
