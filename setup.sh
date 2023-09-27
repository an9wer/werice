#!/bin/bash -e

# backup the original file if existed
backup-origin() {
  local origin=$HOME/$1

  # the original file does not exist or is a symbolic link
  if [[ ! -a $origin || -h $origin ]]; then
    return
  fi

  # the backup file does not exist
  if [[ ! -a $origin.orig ]]; then
    mv "$origin" "$origin".orig
  else
    echo "Error: '$origin.orig' already exists."
    return 1
  fi
}

# link the rice file to the target path
install-rice() {
  local target=$HOME/$1
  local rice=$(readlink -e "$1")

  # make sure the parent directory of target file existed
  mkdir -p "$(dirname "$target")"

  # the target file does not exist
  if [[ ! -a $target ]]; then
    ln -sfv "$rice" "$target"
  # the target path exists and is a symnolic link
  elif [[ -h $target ]]; then
    # the target file links to another file that is not as expected
    if [[ $(readlink -e "$target") != $rice ]]; then
      echo "Error: '$target' is already a symbolic link," \
           "which targets to '$(readlink -e "$target")'."
      return 1
    fi
  # the target path exists but is not a regular file or a symbolic link,
  # instead, it might be a directory, a block special file, etc.
  else
    echo "Error: '$link' already exists and is not a symbolic link."
    return 1
  fi
}


rices=(
  .xinitrc
  .Xmodmap
  .tmux.conf
  .gitconfig
  .bash_profile
  .bashrc
  .bashrc.d/history.sh
  .bashrc.d/alias.sh
  .bashrc.d/prompt.sh
  .bashrc.d/typos.sh
  .bashrc.d/stty.sh
  .bashrc.d/cdf.sh
  .scripts/camdict
  .scripts/numconvert
  .scripts/trash
  .gnupg/gpg-agent.conf
  .config/picom.conf
  .config/ibus/rime/default.custom.yaml
  .config/ibus/rime/double_pinyin_mspy.custom.yaml
  .config/dunst/dunstrc
  .config/dunst/dunstrc.d/99-custom.conf
  .config/redshift.conf
  .config/redshift/hooks/alert
  .config/zathura/zathurarc
  .vimrc
  .vim/swap/
  .vim/after/ftplugin/c.vim
  .vim/after/ftplugin/sh.vim
  .vim/after/ftplugin/awk.vim
  .vim/after/ftplugin/rst.vim
  .vim/after/ftplugin/vim.vim
  .vim/after/ftplugin/ebuild.vim
  .vim/after/ftplugin/python.vim
  .vim/bundle/vim-system-copy
  .vifm/vifmrc
  .nanorc
  .emacs.d/init.el
  .Trash/
)

for rice in "${rices[@]}"; do
  if [[ $rice =~ /$ ]]; then
    mkdir -pv "$HOME/$rice"
  elif [[ -f $rice || -d $rice ]]; then
    backup-origin "$rice"
    install-rice  "$rice"
  else
    echo "Error: unknown '$rice'"
    exit 1
  fi
done
