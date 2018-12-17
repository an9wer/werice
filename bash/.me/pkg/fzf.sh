ME_LIB_FZF=${ME_LIB_DIR}/fzf
ME_BIN_FZF=${ME_BIN_DIR}/fzf
ME_MAN_FZF=${ME_MAN_DIR}/man1/fzf.1


# installation
# -----------------------------------------------------------------------------
me_install_fzf() {
  if [[ -d ${ME_LIB_FZF} ]]; then
    if [[ ! -L ${ME_BIN_FZF} ]]; then
      ln -sf ${ME_LIB_FZF}/bin/fzf ${ME_BIN_FZF}
    fi
    if [[ ! -L ${ME_MAN_FZF} ]]; then
      ln -sf ${ME_LIB_FZF}/man/man1/fzf.1 ${ME_MAN_FZF}
      mandb &> /dev/null
    fi
    return 0
  fi

  me_info "start to install fzf..."
  git clone --depth 1 "https://github.com/junegunn/fzf.git" ${ME_LIB_FZF}
  local version=$(
    curl https://github.com/junegunn/fzf-bin/releases/latest |
    sed -r "s/.*([0-9]+\.[0-9]+\.[0-9]).*/\1/"
  )
  local archi=$(uname -sm)
  local tgz=
  case "$archi" in
    Linux\ armv5*)   tgz=fzf-${version}-linux_${binary_arch:-arm5}.tgz    ;;
    Linux\ armv6*)   tgz=fzf-${version}-linux_${binary_arch:-arm6}.tgz    ;;
    Linux\ armv7*)   tgz=fzf-${version}-linux_${binary_arch:-arm7}.tgz    ;;
    Linux\ armv8*)   tgz=fzf-${version}-linux_${binary_arch:-arm8}.tgz    ;;
    Linux\ aarch64*) tgz=fzf-${version}-linux_${binary_arch:-arm8}.tgz    ;;
    Linux\ *64)      tgz=fzf-${version}-linux_${binary_arch:-amd64}.tgz   ;;
    Linux\ *86)      tgz=fzf-${version}-linux_${binary_arch:-386}.tgz     ;;
    *)             me warn "cannot install fzf in this machine"; return 1 ;;
  esac

  local url=https://github.com/junegunn/fzf-bin/releases/download/${version}/${tgz}
  curl -fL ${url} | tar -C ${ME_LIB_FZF}/bin -zxf -
  if (( $? == 0 )); then
    chmod 755 ${ME_LIB_FZF}/bin/fzf
    ln -sf ${ME_LIB_FZF}/bin/fzf ${ME_BIN_FZF}
    ln -sf ${ME_LIB_FZF}/man/man1/fzf.1 ${ME_MAN_FZF}
    mandb &> /dev/null
  fi
}

me_uninstall_fzf() {
  printf "It'll remove:\n"
  printf "    (1): ${ME_BIN_FZF}\n"
  printf "    (2): ${ME_LIB_FZF}\n"
  printf "are you sure? (y/n): "

  local sure
  read -r sure
  if [[ "${sure}" =~ [Y/y] ]]; then
    rm ${ME_BIN_FZF}
    rm -rf ${ME_LIB_FZF}
    me_info "fzf has been uninstalled :)"
  fi 
}

me_unset_fzf() {
  unset -v ME_BIN_FZF ME_LIB_FZF
  unset -f me_install_fzf me_uninstall_fzf
}
