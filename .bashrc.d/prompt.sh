# Wrapping the format code in '\[' and '\]' can avoid prompt issues when
# scrolling command history.
# thx: https://superuser.com/a/980982
# thx: http://tldp.org/HOWTO/Bash-Prompt-HOWTO/nonprintingchars.html
ME_PROMPT_END='\[\e[0m\]'
ME_PROMPT_BOLD='\[\e[1m\]'
ME_PROMPT_ITALIC='\[\e[3m\]'
ME_PROMPT_BLACK='\[\e[90m\]'
ME_PROMPT_RED='\[\e[91m\]'
ME_PROMPT_GREEN='\[\e[92m\]'
ME_PROMPT_YELLOW='\[\e[93m\]'
ME_PROMPT_BLUE='\[\e[94m\]'
ME_PROMPT_BLUE2='\[\e[3;49;90m\]'
ME_PROMPT_MAGENTA='\[\e[95m\]'
ME_PROMPT_CYAN='\[\e[96m\]'
ME_PROMPT_WHITE='\[\e[97m\]'


_me_venv_prompt() {
  [[ -n ${VIRTUAL_ENV} ]] && echo "(${VIRTUAL_ENV}) "
}

_me_git_prompt() {
  which git &> /dev/null || return
  git rev-parse --is-inside-work-tree &> /dev/null || return

  git symbolic-ref --short HEAD &>/dev/null &&
    local branch="${ME_PROMPT_GREEN}$(git symbolic-ref --short HEAD)" ||
    local branch="HEAD detached at ${ME_PROMPT_MAGENTA}$(git rev-parse --short HEAD)" 

  (( $(git status -s -uno | wc -l) == 0 )) &&
    local status="${ME_PROMPT_GREEN}:)" ||
    local status="${ME_PROMPT_RED}:("

  echo "G ${ME_PROMPT_BOLD}${branch} ${status}${ME_PROMPT_END} "
}

_me_ps1() {
  local ES=$?
  local psline
  psline=$(pstree -s $$)
  psline=$(echo "$psline" | head -n1 | sed -e 's/-[-+]-pstree$//' -e 's/---/ -> /g')

  PS1=""
  PS1+="${ME_PROMPT_BOLD}.--==${ME_PROMPT_END} "
  PS1+="$(_me_venv_prompt)"
  PS1+="${ME_PROMPT_BOLD}${ME_PROMPT_RED}\u@${HOSTNAME}${ME_PROMPT_END} "
  PS1+="at ${ME_PROMPT_BOLD}${ME_PROMPT_BLUE}\t${ME_PROMPT_END} "
  PS1+="in ${ME_PROMPT_BOLD}${ME_PROMPT_YELLOW}\w${ME_PROMPT_END} "
  PS1+="JB ${ME_PROMPT_CYAN}\j${ME_PROMPT_END} "
  if (( $ES == 0 )); then
    PS1+="ES ${ME_PROMPT_GREEN}$ES${ME_PROMPT_END} "
  else
    PS1+="ES ${ME_PROMPT_RED}$ES${ME_PROMPT_END} "
  fi
  PS1+="$(_me_git_prompt) \n"
  PS1+="${ME_PROMPT_BOLD}·     ${ME_PROMPT_END} ${ME_PROMPT_BOLD}${ME_PROMPT_BLACK}${psline}${ME_PROMPT_END}\n"
  PS1+=" ${ME_PROMPT_BOLD}\\\`--===${ME_PROMPT_END} ${ME_PROMPT_GREEN}\$${ME_PROMPT_END} "
}

# ps1
PROMPT_COMMAND="_me_ps1"$'\n'$PROMPT_COMMAND

# ps2
PS2="${ME_PROMPT_BOLD}${ME_PROMPT_YELLOW} \\\`--=== > ${ME_PROMPT_END}"
