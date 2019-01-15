ME_LIB_DASHT=${ME_LIB_DIR}/dasht
ME_BIN_DASHT=(
  ${ME_BIN_DIR}/dasht
  ${ME_BIN_DIR}/dasht-docsets
  ${ME_BIN_DIR}/dasht-docsets-extract
  ${ME_BIN_DIR}/dasht-docsets-install
  ${ME_BIN_DIR}/dasht-docsets-remove
  ${ME_BIN_DIR}/dasht-docsets-update
  ${ME_BIN_DIR}/dasht-query-exec
  ${ME_BIN_DIR}/dasht-query-html
  ${ME_BIN_DIR}/dasht-query-line
  ${ME_BIN_DIR}/dasht-server
  ${ME_BIN_DIR}/dasht-server-http
)
ME_MAN_DASHT=(
  ${ME_MAN_DIR}/man1/dasht.1
  ${ME_MAN_DIR}/man1/dasht-docsets.1
  ${ME_MAN_DIR}/man1/dasht-docsets-extract.1
  ${ME_MAN_DIR}/man1/dasht-docsets-install.1
  ${ME_MAN_DIR}/man1/dasht-docsets-remove.1
  ${ME_MAN_DIR}/man1/dasht-docsets-update.1
  ${ME_MAN_DIR}/man1/dasht-qurey-exec.1
  ${ME_MAN_DIR}/man1/dasht-query-html.1
  ${ME_MAN_DIR}/man1/dasht-query-line.1
  ${ME_MAN_DIR}/man1/dasht-server.1
  ${ME_MAN_DIR}/man1/dasht-server-http.1
)


# Installation
# -----------------------------------------------------------------------------
me_install_dasht() {
  if [[ -d ${ME_LIB_DASHT} ]]; then
    local bin man
    for bin in ${ME_BIN_DASHT[@]}; do
      [[ ! -L ${bin} ]] && ln -sf "${ME_LIB_DASHT}/bin/${bin##*/}" "${bin}"
    done

    for man in ${ME_MAN_DASHT[@]}; do
      [[ ! -L ${man} ]] && ln -sf "${ME_LIB_DASHT}/man/man1/${man##*/}" "${man}"
    done
    mandb &> /dev/null

    return 0
  fi

  me_info "start to install dasht..."
  git clone --depth 1 "https://github.com/sunaku/dasht.git" "${ME_LIB_DASHT}"
  if (( $? == 0 )); then
    for bin in ${ME_BIN_DASHT[@]}; do
      chmod 755 "${ME_LIB_DASHT}/bin/${bin##*/}"
      ln -sf "${ME_LIB_DASHT}/bin/${bin##*/}" "${bin}"
    done

    for man in ${ME_MAN_DASHT[@]}; do
      ln -sf "${ME_LIB_DASHT}/man/man1/${man##*/}" "${man}"
    done
    mandb &> /dev/null
  fi

}

me_uninstall_dasht() {
  printf "It'll remove:\n"
  printf "    (1): ${ME_BIN_DIR}/dasht*\n"
  printf "    (2): ${ME_MAN_DIR}/man/man1/dasht*\n"
  printf "    (3): ${ME_LIB_DASHT}\n"
  printf "are you sure? (y/n): "

  local sure
  read -r sure
  if [[ "${sure}" =~ [Y/y] ]]; then
    local bin man
    for bin in ${ME_BIN_DASHT[@]}; do
      rm ${bin}
    done

    for man in ${ME_MAN_DASHT[@]}; do
      rm ${man}
    done
    mandb &> /dev/null

    rm -rf ${ME_LIB_DASHT}
    me_info "DASHT has been uninstalled :)"
  fi
}

me_unset_dasht() {
  unset -v ME_BIN_DASHT ME_MAN_DASHT ME_LIB_DASHT
  unset -f me_install_dasht me_uninstall_dasht me_unset_dasht
}


# The hack way
# -----------------------------------------------------------------------------
dasht() {
  # Force to run basht in bash environment (default is sh)
  (( ${#@} != 1 )) && { bash -c "command dasht $@"; return $?; }

  local DASHT_DOCSETS_DIR=${XDG_DATA_HOME:-$HOME/.local/share}/dasht/docsets

  [[ $* == Bash ]] && {
    w3m ${DASHT_DOCSETS_DIR}/Bash.docset/Contents/Resources/Documents/bash/index.html
    return $?
  }
  [[ $* == Python_3 ]] && {
    w3m ${DASHT_DOCSETS_DIR}/Python_3.docset/Contents/Resources/Documents/doc/index.html
    return $?
  }
}
