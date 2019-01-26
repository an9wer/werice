_me_info() {
  printf "${ME_ANSI_BOLD}${ME_ANSI_CYAN}%s${ME_ANSI_END}\n" "$*"
}

_me_warn() {
  printf "${ME_ANSI_BOLD}${ME_ANSI_YELLOW}%s${ME_ANSI_END}\n" "$*"
}

_me_err() {
  printf "${ME_ANSI_BOLD}${ME_ANSI_MAGENTA}%s${ME_ANSI_END}\n" "$*"
}

_me_die() {
  _me_err "$@"; exit 1
}
