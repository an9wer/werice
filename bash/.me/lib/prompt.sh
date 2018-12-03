me_git_prompt() {
  which git &> /dev/null || return
  git rev-parse --is-inside-work-tree &> /dev/null || return

  echo "($(git symbolic-ref --short HEAD))"
}

ps1_command() {
  # Q: prompting need to wrap '\[' and '\]' to every color variable to avoid
  #    position issure?
  # thx: https://superuser.com/a/980982

  PS1="${ME_ANSI_YELLOW}┏─━ "
  PS1+="${ME_ANSI_BOLD}${ME_ANSI_GREEN}\u@\h${ME_ANSI_END} "
  PS1+="at ${ME_ANSI_BOLD}${ME_ANSI_RED}\t${ME_ANSI_END} "
  PS1+="in ${ME_ANSI_BOLD}${ME_ANSI_BLUE}\w${ME_ANSI_END} "
  PS1+="${ME_ANSI_BOLD}${ME_ANSI_MAGENTA}$(me_git_prompt)${ME_ANSI_END}\n"
  PS1+="${ME_ANSI_YELLOW}┗─━ \$ ${ME_ANSI_END}"
}

# ps1
PROMPT_COMMAND=$PROMPT_COMMAND$'\n''ps1_command;'

# ps2
PS2="${ME_ANSI_YELLOW}┗─━ > ${ME_ANSI_END}"
