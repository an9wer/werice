me_info() {
  printf "${ME_ANSI_BOLD}${ME_ANSI_BLUE}%s${ME_ANSI_END}\n" "$*"
}

me_warn() {
  printf "${ME_ANSI_BOLD}${ME_ANSI_YELLOW}%s${ME_ANSI_END}\n" "$*"
}

me_error() {
  printf "${ME_ANSI_BOLD}${ME_ANSI_RED}%s${ME_ANSI_END}\n" "$*"
}
