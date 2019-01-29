if [[ $1 == install ]]; then
  source "$ME_UTIL"
  [[ -d $ME_SRC_DIR/base16 ]] &&
    _me_die "$ME_ES_FAILURE" "Package 'base16' has already been installed."

  git clone --branch master --single-branch --depth 1 \
    "https://github.com/chriskempson/base16-shell.git" "$ME_SRC_DIR/base16"


elif [[ $1 == update ]]; then
  source "$ME_UTIL"
  [[ ! -d $ME_SRC_DIR/base16 ]] &&
    _me_die "$ME_ES_FAILURE" "Package 'base16' hasn't been installed."

  cd "$ME_SRC_DIR/base16"
  git pull origin master


elif [[ $1 == remove ]]; then
  source "$ME_UTIL"
  rm -rf "$ME_SRC_DIR/base16"


else
  base16() {
    # Display current scheme
    if [[ -z $1 ]]; then
      [[ ! -f $ME_BASHRC_DIR/base16-scheme.sh ]] && { echo "No scheme."; return; }
      echo $(sed -nr '4 s/# (.*) scheme.*/\1/p' "$ME_BASHRC_DIR/base16-scheme.sh")
      return
    fi

    # Verify argument $1 which points to some scheme
    if [[ -z $(ls $ME_SRC_DIR/base16/scripts/base16-*.sh |
               xargs -n1 basename -s .sh | cut -c 8- | grep "^$1$") ]]; then
      echo "Unknown scheme."
      return 1
    fi

    # Install scheme
    cp -f \
      "$ME_SRC_DIR/base16/scripts/base16-$1.sh" \
      "$ME_BASHRC_DIR/base16-scheme.sh"

    source "${ME_SRC_DIR}/base16/scripts/base16-$1.sh"
  }

  base16-clear() {
    rm -f "$ME_BASHRC_DIR/base16-scheme.sh"
    echo "Please restart your shell to make changes effect."
  }

  # Bash completion of base16
  complete -W \
    "$(ls $ME_SRC_DIR/base16/scripts/base16-*.sh |
        xargs -n1 basename -s .sh | cut -c 8-)" \
    base16

fi
