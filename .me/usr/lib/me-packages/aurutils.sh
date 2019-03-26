pkg=aurutils pkg_dir=$ME_SRC_DIR/$pkg

build() {
  set -e
  cd "$pkg_dir"
  make &&
  make DESTDIR="$ME_DIR" SHRDIR="/usr" AUR_LIB_DIR="$ME_LIB_DIR/aurutils" install
  rm -rf "$ME_USR_DIR/licenses"
  mandb &> /dev/null
}

if [[ $1 == install ]]; then
  source "$ME_UTIL"

  # TODO: require jq wget parallel
  _me_package_installed "$pkg"
  git clone --branch master --single-branch --depth 1 \
    "https://github.com/AladW/aurutils.git" "$pkg_dir"
  build


elif [[ $1 == update ]]; then
  source "$ME_UTIL"

  _me_package_uninstalled "$pkg"
  cd "$pkg_dir"
  git pull origin master
  build


elif [[ $1 == remove ]]; then
  rm -rf "$ME_LIB_DIR"/aurutils
  rm -rf "$ME_MAN_DIR"/man1/aur*
  rm -rf "$ME_MAN_DIR"/man7/aur*
  rm -rf "$ME_BIN_DIR"/aur
  rm -rf "$ME_USR_DIR/bash-completion/completions/aur"
  rm -rf "$pkg_dir"
  mandb &> /dev/null


else
  source "$ME_USR_DIR/bash-completion/completions/aur"



fi

unset pkg pkg_dir build

