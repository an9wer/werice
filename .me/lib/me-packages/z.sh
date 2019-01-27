if [[ $1 == install ]]; then
  source "$ME_UTIL"
  me package install z
  if (( $? == $ME_ES_UNKNOWN_RELEASE )); then
    [[ -d $ME_CACHE_DIR/z ]] &&
      _me_die "$ME_ES_FAILURE" "Package 'z' has already been installed."

    set -e
    git clone --branch master --single-branch --depth 1 \
      https://github.com/rupa/z.git "$ME_CACHE_DIR/z"
    ln -sf "$ME_CACHE_DIR/z/z.1" "$ME_MAN_DIR/man1/z.1" && mandb &> /dev/null
  fi


elif [[ $1 == update ]]; then
  source "$ME_UTIL"
  [[ ! -d $ME_CACHE_DIR/z ]] &&
    _me_die "$ME_ES_FAILURE" "Package 'z' hasn't been installed."

  me package update z
  if (( $? == $ME_ES_UNKNOWN_RELEASE )); then
    set -e
    cd "$ME_CACHE_DIR/z"
    git pull origin master
    ln -sf "$ME_CACHE_DIR/z/z.1" "$ME_MAN_DIR/man1/z.1" && mandb &> /dev/null
  fi


elif [[ $1 == remove ]]; then
  source "$ME_UTIL"
  me package remove z
  if (( $? == $ME_ES_UNKNOWN_RELEASE )); then
    set -e
    rm "$ME_MAN_DIR?man1/z.1" && mandb &> /dev/null
    rm -rf "$ME_CACHE_DIR/z"
  fi


else
  if [[ -r /usr/share/z/z.sh ]]; then
    source /usr/share/z/z.sh
  elif [[ -r $ME_CACHE_DIR/z/z.sh ]]; then
    source "$ME_CACHE_DIR/z/z.sh"
  fi

fi
