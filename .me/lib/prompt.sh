me_venv_prompt() {
  [[ -n ${VIRTUAL_ENV} ]] && echo "(${VIRTUAL_ENV}) "
}

me_git_prompt() {
  which git &> /dev/null || return
  git rev-parse --is-inside-work-tree &> /dev/null || return

  git symbolic-ref --short HEAD &>/dev/null &&
    local branch="${ME_PROMPT_MAGENTA}$(git symbolic-ref --short HEAD)" ||
    local branch="HEAD detached at ${ME_PROMPT_MAGENTA}$(git rev-parse --short HEAD)" 

  (( $(git status -s -uno | wc -l) == 0 )) &&
    local status="${ME_PROMPT_GREEN}✓" ||
    local status="${ME_PROMPT_RED}✗"

  echo "(${ME_PROMPT_BOLD}${branch} ${status}${ME_PROMPT_END})"
}

ps1_command() {
  PS1="${ME_PROMPT_YELLOW}┏─━${ME_PROMPT_END} "
  PS1+="$(me_venv_prompt)"
  PS1+="${ME_PROMPT_BOLD}${ME_PROMPT_GREEN}\u@\h${ME_PROMPT_END} "
  PS1+="at ${ME_PROMPT_BOLD}${ME_PROMPT_RED}\t${ME_PROMPT_END} "
  PS1+="in ${ME_PROMPT_BOLD}${ME_PROMPT_BLUE}\w${ME_PROMPT_END} "
  PS1+="$(me_git_prompt)\n"
  PS1+="${ME_PROMPT_YELLOW}┗─━ \$ ${ME_PROMPT_END}"
}

# ps1
PROMPT_COMMAND=$PROMPT_COMMAND$'\n''ps1_command;'

# ps2
PS2="${ME_PROMPT_YELLOW}┗─━ > ${ME_PROMPT_END}"
