# Exit status
ME_ES_SUCCESS=0
ME_ES_FAILURE=1
ME_ES_UNKNOWN_SYSTEM=2
ME_ES_UNKNOWN_RELEASE=3
ME_ES_UNKNOWN_PACKAGE=4
ME_ES_UNKNOWN_ARGUMENT=5

# Ansi colors
ME_ANSI_END='\e[0m'
ME_ANSI_BOLD='\e[1m'
ME_ANSI_RED='\e[91m'
ME_ANSI_GREEN='\e[92m'
ME_ANSI_YELLOW='\e[93m'
ME_ANSI_BLUE='\e[94m'
ME_ANSI_MAGENTA='\e[95m'
ME_ANSI_CYAN='\e[96m'
ME_ANSI_WHITE='\e[97m'

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
  # $1: Exit status
  # ${@:2}: Exit messages
  _me_err "${@:2}"
  exit "$1"
}
