# Exit status
_ES_SUCCESS=0
_ES_FAILURE=1
_ES_UNKNOWN_SYSTEM=2
_ES_UNKNOWN_RELEASE=3
_ES_UNKNOWN_PACKAGE=4
_ES_UNKNOWN_ARGUMENT=5

# Ansi colors
_ANSI_END='\e[0m'
_ANSI_BOLD='\e[1m'
_ANSI_RED='\e[91m'
_ANSI_GREEN='\e[92m'
_ANSI_YELLOW='\e[93m'
_ANSI_BLUE='\e[94m'
_ANSI_MAGENTA='\e[95m'
_ANSI_CYAN='\e[96m'
_ANSI_WHITE='\e[97m'

_info() {
  printf "${_ANSI_BOLD}${_ANSI_CYAN}%s${_ANSI_END}\n" "$*"
}

_warn() {
  printf "${_ANSI_BOLD}${_ANSI_YELLOW}%s${_ANSI_END}\n" "$*"
}

_err() {
  printf "${_ANSI_BOLD}${_ANSI_MAGENTA}%s${_ANSI_END}\n" "$*"
}

_die() {
  # :param $1: Exit status
  # :param ${@:2}: Exit messages
  _err "${@:2}"
  exit "$1"
}

