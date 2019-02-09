export ME_DIR=$(dirname ${BASH_SOURCE[0]})
export ME_BIN_DIR=${ME_DIR}/usr/bin
export ME_MAN_DIR=${ME_DIR}/usr/man
export ME_LIB_DIR=${ME_DIR}/usr/lib
export ME_SRC_DIR=${ME_DIR}//usr/src
export ME_LOG_DIR=${ME_DIR}/var/log
export ME_ETC_DIR=${ME_DIR}/etc
export ME_BASHRC_DIR=${ME_DIR}/bashrc.d

export ME_UTIL=${ME_DIR}/me-util.sh

# Obsolete:
export ME_PKG_DIR=${ME_DIR}/pkg
export ME_JOB_DIR=${ME_DIR}/job


# Environment variable
# -----------------------------------------------------------------------------
export EDITOR=vim
export VISUAL=vim

# fc builtin editor
export FCEDIT=vim

# History
export HISTFILE=~/.bash_history
export HISTSIZE=        # unlimited
export HISTFILESIZE=    # unlimited
export HISTTIMEFORMAT="[%Y/%m/%d %T]  "
export HISTCONTROL=ignoredups
export HISTIGNORE="ls:ll:pwd:vim:history:git status"

[[ ! "${PATH}" =~ "${ME_BIN_DIR}" ]] && export PATH="${ME_BIN_DIR}:${PATH}"
[[ ! "${PATH}" =~ "${HOME}/.git-extensions" ]] && export PATH="${HOME}/.git-extensions:${PATH}"


# Aliases
# -----------------------------------------------------------------------------
alias ls="ls --color=auto"
alias ll="ls -lh"
alias lsc="ls --color=always"
alias llc="ll --color=always"

alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

alias diff="diff --color=auto"

alias info="info --vi-keys"

alias sourceb="source ~/.bashrc"

alias vimv="vim ~/.vimrc"
alias vimb="vim ~/.bashrc"
alias vimt="vim ~/.tmux.conf"
alias vimm="vim ~/.me/me.sh"
alias vimtest="vim --noplugin -N -u"

alias todo="vim ~/Documents/notes/todo.wiki"

# Virtual console
[[ $(tty) =~ /dev/tty ]] && {
  setfont Tamsyn10x20r &> /dev/null
  setterm --blength 0
}

# Load custom bashrc
# -----------------------------------------------------------------------------
for bashrc in $(find ${ME_BASHRC_DIR} -name "*.sh"); do
  source ${bashrc}
done

# Say hello
command -v neofetch &> /dev/null && neofetch
