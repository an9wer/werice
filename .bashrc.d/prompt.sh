shopt -s checkjobs

declare -xi BASH_INTERACTIVE_STACKS+=1

# Wrapping the format code within '\[' and '\]' to avoid prompt issues
# when scrolling command history. Find more:
#  - https://superuser.com/a/980982
#  - http://tldp.org/HOWTO/Bash-Prompt-HOWTO/nonprintingchars.html
PS_PROMPT_END='\[\e[0m\]'
PS_PROMPT_BOLD='\[\e[1m\]'
PS_PROMPT_ITALIC='\[\e[3m\]'
PS_PROMPT_REVERSE='\[\e[7m\]'
PS_PROMPT_BLACK='\[\e[90m\]'
PS_PROMPT_RED='\[\e[91m\]'
PS_PROMPT_GREEN='\[\e[92m\]'
PS_PROMPT_YELLOW='\[\e[93m\]'
PS_PROMPT_BLUE='\[\e[94m\]'
PS_PROMPT_BLUE2='\[\e[3;49;90m\]'
PS_PROMPT_MAGENTA='\[\e[95m\]'
PS_PROMPT_CYAN='\[\e[96m\]'
PS_PROMPT_WHITE='\[\e[97m\]'

# tell venv not to set bash prompt
export VIRTUAL_ENV_DISABLE_PROMPT='true'
# let me set bash prompt for venv instead
__venv_ps1() {
  [[ -n ${VIRTUAL_ENV} ]] && echo "(${VIRTUAL_ENV}) "
}

if [[ -f /usr/share/git/git-prompt.sh ]]; then
  source /usr/share/git/git-prompt.sh
  # show staged and unstaged changes
  GIT_PS1_SHOWDIRTYSTATE='true'
  # show untracked files
  GIT_PS1_SHOWUNTRACKEDFILES='true'
  # show stash state
  GIT_PS1_SHOWSTASHSTATE='true'
  # show verbose information when checking out as a detached HEAD
  GIT_PS1_DESCRIBE_STYLE='branch'
else
  __git_ps1() {
    # check the existence of git command
    command -v git &> /dev/null || return
    # check current working directory is inside git work tree
    git rev-parse --is-inside-work-tree &> /dev/null || return
    # get current branch or detached HEAD commit
    branch=$(git branch | sed -e 's/\* (HEAD detached at \(.*\))/* \1/' -n -e 's/\* \(.*\)/\1/p')
    # get state of current git repo
    git diff --no-ext-diff --quiet || state='*'
    echo "[${branch} ${state}]"
  }
fi

__ps1() {
  local ES=$?

  PS1=""

  # line 1
  PS1+="${PS_PROMPT_BOLD}.--==${PS_PROMPT_END} "
  PS1+="$(__venv_ps1)"
  PS1+="${PS_PROMPT_BOLD}${PS_PROMPT_RED}\u@\h${PS_PROMPT_END} "
  PS1+="at ${PS_PROMPT_BOLD}${PS_PROMPT_BLUE}\t${PS_PROMPT_END} "
  PS1+="in ${PS_PROMPT_BOLD}${PS_PROMPT_YELLOW}\w${PS_PROMPT_END} "
  PS1+="${PS_PROMPT_GREEN}$(__git_ps1)${PS_PROMPT_END}"
  PS1+="\n"

  # line 2
  PS1+="${PS_PROMPT_BOLD}·     ${PS_PROMPT_END} "
  PS1+="${PS_PROMPT_BOLD}${PS_PROMPT_BLACK}$(tty)${PS_PROMPT_END}"
  PS1+="${PS_PROMPT_BOLD}${PS_PROMPT_BLACK} | exit ${ES}${PS_PROMPT_END}"
  if (( ${BASH_INTERACTIVE_STACKS} > 1 )); then
    PS1+="${PS_PROMPT_BOLD}${PS_PROMPT_BLACK} | ${PS_PROMPT_REVERSE}bash ${BASH_INTERACTIVE_STACKS}${PS_PROMPT_END}"
  else
    PS1+="${PS_PROMPT_BOLD}${PS_PROMPT_BLACK} | bash ${BASH_INTERACTIVE_STACKS}${PS_PROMPT_END}"
  fi
  if (( $(jobs -p | wc -l) > 0 )); then
    PS1+="${PS_PROMPT_BOLD}${PS_PROMPT_BLACK} | ${PS_PROMPT_REVERSE}job No.\j${PS_PROMPT_END}"
  else
    PS1+="${PS_PROMPT_BOLD}${PS_PROMPT_BLACK} | job \j${PS_PROMPT_END}"
  fi
  PS1+="${PS_PROMPT_BOLD}${PS_PROMPT_BLACK} | history No.\!${PS_PROMPT_END}"
  PS1+="${PS_PROMPT_BOLD}${PS_PROMPT_BLACK} | command No.\#${PS_PROMPT_END}"
  PS1+="\n"

  # line 3
  PS1+=" ${PS_PROMPT_BOLD}\\\`--===${PS_PROMPT_END} ${PS_PROMPT_GREEN}\$${PS_PROMPT_END} "
}

# PS1
PROMPT_COMMAND="__ps1"$'\n'$PROMPT_COMMAND

# PS2
PS2="${PS_PROMPT_BOLD} \\\`--=== ${PS_PROMPT_GREEN}> ${PS_PROMPT_END}"
