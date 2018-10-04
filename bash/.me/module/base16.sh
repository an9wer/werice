ME_LIB_BASE16=${ME_LIB_DIR}/base16


# installation
# -----------------------------------------------------------------------------
me_install_base16() {
  [[ -d ${ME_LIB_BASE16} ]] && return 0

  me prompt "start to install base16..."
  git clone --depth 1 \
    "https://github.com/chriskempson/base16-shell.git" ${ME_LIB_BASE16}

  if (( $? == 0 )); then
    # default base16
    source ${ME_LIB_BASE16}/scripts/base16-google-dark.sh

    # completion
    complete -W "$(ls ${ME_LIB_BASE16}/scripts/base16-*.sh |
      sed -E 's/.*base16-(.*).sh/\1 /g')" base16
  fi
}

me_uninstall_base16() {
  printf "It'll remove:\n"
  printf "    (1): ${ME_LIB_BASE16}\n"
  printf "are you sure? (y/n): "

  local sure
  read -r sure
  if [[ "${sure}" =~ [Y/y] ]]; then
    rm -rf ${ME_LIB_BASE16}
    me prompt "base64 has been uninstalled :)"
  fi 
}

me_unset_base16() {
  complete -r base16
  unset -v ME_LIB_BASE16
  unset -f me_install_base16 me_uninstall_base16 me_unset_base16 base16
}

# usage
# -----------------------------------------------------------------------------
base16() {
  source ${ME_LIB_BASE16}/scripts/base16-${1}.sh
}

[[ -d ${ME_LIB_BASE16}/scripts ]] && {
  # default base16
  source ${ME_LIB_BASE16}/scripts/base16-google-dark.sh

  # completion
  complete -W "$(ls ${ME_LIB_BASE16}/scripts/base16-*.sh |
    sed -E 's/.*base16-(.*).sh/\1 /g')" base16
}
