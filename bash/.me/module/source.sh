# installation
# -----------------------------------------------------------------------------
me_unset_source() {
  unset -f me_unset_source source
}


# usage
# -----------------------------------------------------------------------------
source() {
  # python virtual environment prompt
  if [[ $* =~ "/bin/activate" ]]; then
    # disable python default virtual enable prompt used by (venv)/bin/activate
    VIRTUAL_ENV_DISABLE_PROMPT=1

    if builtin source "$*"; then
      # record old virtual ps1 used by (venv)/bin/activate
      _OLD_VIRTUAL_PS1="$PS1"

      local path=$(readlink -ev "$*")
      local venv="${path%%/bin/activate}"
      local BOLD="\[\e[1m\]" RED="\[\e[91m\]" GREEN="\[\e[92m\]"
      local BLUE="\[\e[94m\]" YELLOW="\[\e[93m\]" END="\[\e[0m\]"
      PS1="${YELLOW}┏─━ ${END}($venv) ${BOLD}${GREEN}\u@\h${END} "
      PS1+="at ${BOLD}${RED}\t${END} in ${BOLD}${BLUE}\w${END}\n"
      PS1+="${YELLOW}┗─━ \$${END} "
      export PS1
    fi
  else
    builtin source "$*"
  fi
}
