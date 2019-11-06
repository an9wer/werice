# Wrapping the format code in '\[' and '\]' can avoid prompt issues when
# scrolling command history.
# thx: https://superuser.com/a/980982
# thx: http://tldp.org/HOWTO/Bash-Prompt-HOWTO/nonprintingchars.html
PS_PROMPT_END='\[\e[0m\]'
PS_PROMPT_BOLD='\[\e[1m\]'
PS_PROMPT_ITALIC='\[\e[3m\]'
PS_PROMPT_BLACK='\[\e[90m\]'
PS_PROMPT_RED='\[\e[91m\]'
PS_PROMPT_GREEN='\[\e[92m\]'
PS_PROMPT_YELLOW='\[\e[93m\]'
PS_PROMPT_BLUE='\[\e[94m\]'
PS_PROMPT_BLUE2='\[\e[3;49;90m\]'
PS_PROMPT_MAGENTA='\[\e[95m\]'
PS_PROMPT_CYAN='\[\e[96m\]'
PS_PROMPT_WHITE='\[\e[97m\]'


_ps1_venv_prompt() {
  [[ -n ${VIRTUAL_ENV} ]] && echo "(${VIRTUAL_ENV}) "
}

_ps1_git_prompt() {
  which git &> /dev/null || return
  git rev-parse --is-inside-work-tree &> /dev/null || return

  git symbolic-ref --short HEAD &>/dev/null &&
    local branch="${PS_PROMPT_GREEN}$(git symbolic-ref --short HEAD)" ||
    local branch="HEAD detached at ${PS_PROMPT_MAGENTA}$(git rev-parse --short HEAD)" 

  (( $(git status -s -uno | wc -l) == 0 )) &&
    local status="${PS_PROMPT_GREEN}:)" ||
    local status="${PS_PROMPT_RED}:("

  echo "G ${PS_PROMPT_BOLD}${branch} ${status}${PS_PROMPT_END} "
}

_ps1() {
  local ES=$?
  local psline
  psline=$(pstree -s $$)
  psline=$(echo "$psline" | head -n1 | sed -e 's/-[-+]-pstree$//' -e 's/---/ -> /g')

  PS1=""
  PS1+="${PS_PROMPT_BOLD}.--==${PS_PROMPT_END} "
  PS1+="$(_ps1_venv_prompt)"
  PS1+="${PS_PROMPT_BOLD}${PS_PROMPT_RED}\u@${HOSTNA}${PS_PROMPT_END} "
  PS1+="at ${PS_PROMPT_BOLD}${PS_PROMPT_BLUE}\t${PS_PROMPT_END} "
  PS1+="in ${PS_PROMPT_BOLD}${PS_PROMPT_YELLOW}\w${PS_PROMPT_END} "
  PS1+="JB ${PS_PROMPT_CYAN}\j${PS_PROMPT_END} "
  if (( $ES == 0 )); then
    PS1+="ES ${PS_PROMPT_GREEN}$ES${PS_PROMPT_END} "
  else
    PS1+="ES ${PS_PROMPT_RED}$ES${PS_PROMPT_END} "
  fi
  PS1+="$(_ps1_git_prompt) \n"
  PS1+="${PS_PROMPT_BOLD}·     ${PS_PROMPT_END} ${PS_PROMPT_BOLD}${PS_PROMPT_BLACK}${psline}${PS_PROMPT_END}\n"
  PS1+=" ${PS_PROMPT_BOLD}\\\`--===${PS_PROMPT_END} ${PS_PROMPT_GREEN}\$${PS_PROMPT_END} "
}

# ps1
PROMPT_COMMAND="_ps1"$'\n'$PROMPT_COMMAND

# ps2
PS2="${PS_PROMPT_BOLD} \\\`--=== ${PS_PROMPT_GREEN}> ${PS_PROMPT_END}"
