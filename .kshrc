# ksh variables
# ----------------------------------------------------------------------------
PATH=~/.scripts:$PATH

HISTFILE=~/.ksh_history
HISTCONTROL=ignoredups:ignorespace


# environment variables
# ----------------------------------------------------------------------------
# indicate charact encoding
export LC_ALL=C.UTF-8


# key bindings
# ----------------------------------------------------------------------------
if [[ $TERM == st-256color ]]; then
	# Ctrl-Delete
	bind '^[[3;5~'=delete-word-forward
fi


# alias
# ----------------------------------------------------------------------------
alias 1='fg %1'
alias 2='fg %2'
alias 3='fg %3'
alias 4='fg %4'
alias 5='fg %5'
alias 6='fg %6'
alias 7='fg %7'
alias 8='fg %8'
alias 9='fg %9'
alias 0='fg %-'


# prompts
# ----------------------------------------------------------------------------
# disable python virtual environment's default prompt
export VIRTUAL_ENV_DISABLE_PROMPT=true
# count the number of sh stacks in PS1
export __SH_INTERACTIVE_STACKS=$(($__SH_INTERACTIVE_STACKS + 1))

__ps() {
	local es=$?
	# wrap the format code within '\[' and '\]' to avoid prompt issues
	# when scrolling through command histories. Find more:
	#  - https://superuser.com/a/980982
	#  - http://tldp.org/HOWTO/Bash-Prompt-HOWTO/nonprintingchars.html
	local ANSI_END='\[\e[0m\]'
	local ANSI_BOLD='\[\e[1m\]'
	local ANSI_ITALIC='\[\e[3m\]'
	local ANSI_REVERSE='\[\e[7m\]'
	local ANSI_BLACK='\[\e[90m\]'
	local ANSI_RED='\[\e[91m\]'
	local ANSI_GREEN='\[\e[92m\]'
	local ANSI_YELLOW='\[\e[93m\]'
	local ANSI_BLUE='\[\e[94m\]'
	local ANSI_BLUE2='\[\e[3;49;90m\]'
	local ANSI_MAGENTA='\[\e[95m\]'
	local ANSI_CYAN='\[\e[96m\]'
	local ANSI_WHITE='\[\e[97m\]'

	case "$1" in
	1)	# line 1
		echo -n "${ANSI_BOLD}.--==${ANSI_END} "
		# python virtual environment
		if [[ -n ${VIRTUAL_ENV} ]]; then
			echo -n "(${VIRTUAL_ENV}) "
		fi
		echo -n "${ANSI_BOLD}${ANSI_RED}\u@\h${ANSI_END} "
		echo -n "at ${ANSI_BOLD}${ANSI_BLUE}\\\t${ANSI_END} "
		echo -n "in ${ANSI_BOLD}${ANSI_YELLOW}\w${ANSI_END} "
		# TODO: show git status
		#PS1+="${ANSI_GREEN}$(__git_ps1)${ANSI_END}"
		echo -n "\n"
		# line 2
		echo -n "${ANSI_BOLD}·     ${ANSI_END} "
		echo -n "${ANSI_BOLD}${ANSI_BLACK}$(tty)${ANSI_END}"
		echo -n "${ANSI_BOLD}${ANSI_BLACK} | exit $es${ANSI_END}"
		if (( ${__SH_INTERACTIVE_STACKS} > 1 )); then
			echo -n "${ANSI_BOLD}${ANSI_BLACK} | ${ANSI_REVERSE}sh ${__SH_INTERACTIVE_STACKS}${ANSI_END}"
		else
			echo -n "${ANSI_BOLD}${ANSI_BLACK} | ksh ${__SH_INTERACTIVE_STACKS}${ANSI_END}"
		fi
		if (( $(jobs -p | wc -l) > 0 )); then
			echo -n "${ANSI_BOLD}${ANSI_BLACK} | ${ANSI_REVERSE}job No.\j${ANSI_END}"
		else
			echo -n "${ANSI_BOLD}${ANSI_BLACK} | job \j${ANSI_END}"
		fi
		echo -n "${ANSI_BOLD}${ANSI_BLACK} | history No.\!${ANSI_END}"
		echo -n "${ANSI_BOLD}${ANSI_BLACK} | command No.\#${ANSI_END}"
		echo -n "\n"
		# line 3
		echo -n " ${ANSI_BOLD}\`--=== ${ANSI_GREEN}\$${ANSI_END} "
		;;
	2)	echo -n " ${ANSI_BOLD}\`--=== ${ANSI_GREEN}>${ANSI_END} "
		;;
	esac
}

PS1='$(__ps 1)'
PS2=$(__ps 2)


# customized settings across different systems
# ----------------------------------------------------------------------------
case $(uname) in
Linux   )	;;
OpenBSD )	[[ -d $HOME/.venv ]] && . $HOME/.venv/bin/activate
		;;
esac
