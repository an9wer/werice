# Q: How to check linux distro?
# thx: https://unix.stackexchange.com/a/35190

ME_LIB_LSB_RELEASE=${ME_LIB_DIR}/lsb_release
ME_BIN_LSB_RELEASE=${ME_BIN_DIR}/lsb_release
ME_MAN_LSB_RELEASE=${ME_MAN_DIR}/man1/lsb_release.1

me_install_lsb_release() {
  if [[ -d ${ME_LIB_LSB_RELEASE} ]]; then
    if [[ ! -L ${ME_BIN_LSB_RELEASE} ]]; then
      ln -sf ${ME_LIB_LSB_RELEASE}/lsb_release ${ME_BIN_LSB_RELEASE}
    fi
    if [[ ! -L ${ME_MAN_LSB_RELEASE} ]]; then
      ln -sf ${ME_LIB_LSB_RELEASE}/lsb_release.1 ${ME_MAN_LSB_RELEASE}
    fi
    return 0
  fi

  # Q: How to install lsb_release from source code?
  # thx: http://www.linuxfromscratch.org/blfs/view/8.1/postlfs/lsb-release.html
  me_info "start to install lsb_release..."
  curl -fL "https://downloads.sourceforge.net/lsb/lsb-release-1.4.tar.gz" |
    tar -C ${ME_LIB_LSB_RELEASE} -zxf -
  ${ME_LIB_LSB_RELEASE}/help2man \
    -N --include ${ME_LIB_LSB_RELEASE}/lsb_release.examples \
    --alt_version_key=program_version ${ME_LIB_LSB_RELEASE}/lsb_release \
    > ${ME_LIB_LSB_RELEASE}/lsb_release.1
  if (( $? == 0 )); then
    ln -sf ${ME_LIB_LSB_RELEASE}/lsb_release ${ME_BIN_LSB_RELEASE}
    ln -sf ${ME_LIB_LSB_RELEASE}/lsb_release.1 ${ME_MAN_LSB_RELEASE}
    mandb &> /dev/null
  fi
}

me_uninstall_lsb_release() {
  printf "It'll remove:\n"
  printf "    (1): ${ME_BIN_LSB_RELEASE}\n"
  printf "    (2): ${ME_MAN_LSB_RELEASE}\n"
  printf "    (3): ${ME_LIB_LSB_RELEASE}\n"
  printf "are you sure? (y/n): "

  local sure
  read -r sure
  if [[ "${sure}" =~ [Y/y] ]]; then
    rm ${ME_BIN_LSB_RELEASE}
    rm ${ME_MAN_LSB_RELEASE} && mandb $> /dev/null
    rm -rf ${ME_LIB_LSB_RELEASE}
    me_info "lsb_release has been uninstalled :)"
  fi 
}

me_unset_lsb_release() {
  unset -v ME_BIN_LSB_RELEASE ME_MAN_LSB_RELEASE ME_LIB_LSB_RELEASE
  unset -f me_install_lsb_release me_uninstall_lsb_release me_unset_lsb_release
}
