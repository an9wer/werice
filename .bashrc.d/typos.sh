# Commonly misspelled words
alias sduo=sudo
alias suod=sudo
alias lsbkl=lsblk

# Wrapper of git to fix typos
git() {
  if [[ $1 == stauts ]]; then
    command git status "${@:2}"
  else
    command git "$@"
  fi
}
