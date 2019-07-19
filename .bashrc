# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Virtual console
# -----------------------------------------------------------------------------
[[ $(tty) =~ /dev/tty ]] && {
  setfont Tamsyn10x20r &> /dev/null
  setterm --blength 0
}

# Load custom bashrc
# -----------------------------------------------------------------------------
for rc in $(find ${ME_BASHRC_DIR} -name "*.sh"); do
  source "$rc"
done; unset rc

# Load scripts
# -----------------------------------------------------------------------------
[[ ! "$PATH" =~ "$HOME/scripts" ]] && export PATH="$HOME/.scripts:$PATH"
[[ ! "$PATH" =~ "$HOME/.git-extensions" ]] && export PATH="$HOME/.git-extensions:$PATH"

# Say hello
# -----------------------------------------------------------------------------
if command -v neofetch &> /dev/null; then
  neofetch
fi

# vim: set filetype=sh:
