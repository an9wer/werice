#!/bin/bash -e

backup-origin() {
  local origin=$HOME/$1

  # $origin does not exist or is a symbolic link
  if [[ ! -a $origin || -h $origin ]]; then
    return
  fi

  # $origin.orig does not exist
  if [[ ! -f $origin.orig ]]; then
    mv "$origin" "$origin".orig
  else
    echo "Backup error: '$origin.orig' already exists."
    return 1
  fi
}

install-file() {
  local target=$(readlink -e "$1")
  local link=$HOME/$1
  local linkdir=$(dirname "$link")

  mkdir -p "$linkdir"

  # $link does not exist
  if [[ ! -a $link ]]; then
    ln -sfv "$target" "$link"
  # $link exists and is a symnolic link
  elif [[ -h $link ]]; then
    if [[ $(readlink -e "$link") != $target ]]; then
      ln -sfv "$target" "$link"
    fi
  else
    echo "Install error: '$link' already exists and isn't a symbolic link."
    return 1
  fi
}


rices_to_install=(
  .xinitrc
  .Xmodmap
  .tmux.conf
  .gitconfig
  .bash_profile
  .bashrc
  .bashrc.d/shopt.sh
  .bashrc.d/history.sh
  .bashrc.d/alias.sh
  .bashrc.d/prompt.sh
  .bashrc.d/typos.sh
  .bashrc.d/cd.sh
  .scripts/camdict
  .scripts/dmenu_pass
  .scripts/dmenu_pass_run
  .scripts/dmenu_blog
  .scripts/dmenu_blog_run
  .scripts/numconvert
  .scripts/trash
  .gnupg/gpg-agent.conf
  .config/ibus/rime/default.custom.yaml
  .config/ibus/rime/double_pinyin.custom.yaml
  .config/dunst/dunstrc
  .config/qutebrowser/config.py
  .vim/plugin/tabline.vim
  .vim/ftplugin/python.vim
  .vim/ftplugin/rst.vim
  .vim/ftplugin/sh.vim
  .vim/bundle/vim-system-copy
)

for rice in "${rices_to_install[@]}"; do
  if [[ ! -f $rice ]] && [[ ! -d $rice ]]; then
    echo "Install error: '$rice' is not a file or directory."
    return 1
  fi

  backup-origin "$rice"
  install-file "$rice"
done
