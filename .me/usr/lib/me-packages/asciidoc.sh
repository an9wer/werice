if [[ $1 == install ]]; then
  source "$ME_UTIL"
  [[ -d $ME_SRC_DIR/asciidoc ]] &&
    _me_die "$ME_ES_FAILURE" "Package 'asciidoc' has already been installed."

  set -e
  git clone --branch master --single-branch --depth 1 \
    "https://github.com/asciidoc/asciidoc-py3.git" "$ME_SRC_DIR/asciidoc"
  cd "$ME_SRC_DIR/asciidoc"
  autoconf
  ./configure --prefix="$ME_DIR/usr" --mandir="$ME_MAN_DIR" --sysconfdir="$ME_ETC_DIR"
  make
  make install

elif [[ $1 == update ]]; then
  source "$ME_UTIL"
  [[ ! -d $ME_SRC_DIR/asciidoc ]] &&
    _me_die "$ME_ES_FAILURE" "Package 'asciidoc' has't been installed."

  set -e
  cd "$ME_SRC_DIR/asciidoc"
  git pull origin master
  autoconf
  ./configure --prefix="$ME_DIR/usr" --mandir="$ME_MAN_DIR" --sysconfdir="$ME_ETC_DIR"
  make
  make install

elif [[ $1 == remove ]]; then
  cd  "$ME_SRC_DIR/asciidoc"
  make uninstall
  rm -rf  "$ME_SRC_DIR/asciidoc"

fi
