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

install-rice() {
  local link=$HOME/$1
  local linkdir=$(dirname "$link")
  local target=$(readlink -e "$1")

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


case $USER in
  root )
    HOME=/etc
    rices=(
      portage/package.accept_keywords
      portage/sets/portage.user
      portage/sets/system.user
      portage/sets/net.user
      portage/sets/x11.user
      portage/sets/fonts.user
      portage/sets/apps.user
      portage/package.mask/x11.user
      portage/package.mask/apps.user
      portage/package.use/temporary-confilcts
      portage/savedconfig/x11-wm/dwm-6.2-r12
      portage/savedconfig/x11-terms/st-0.8.4-r7
      portage/savedconfig/x11-misc/dmenu-5.0-r4
      portage/savedconfig/x11-misc/slstatus-9999
      portage/savedconfig/x11-misc/tabbed-0.6-r36
    )
    ;;

  * )
    rices=(
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
      .bashrc.d/stty.sh
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
      .vimrc
      .vim/after/ftplugin/c.vim
      .vim/after/ftplugin/python.vim
      .vim/after/ftplugin/rst.vim
      .vim/after/ftplugin/sh.vim
      .vim/after/ftplugin/vim.vim
      .vim/plugin/tabline.vim
      .vim/bundle/vim-system-copy
    )
    ;;
esac

for rice in "${rices[@]}"; do
  if [[ ! -f $rice ]] && [[ ! -d $rice ]]; then
    echo "Install error: '$rice' is not a file or directory."
    return 1
  fi

  backup-origin "$rice"
  install-rice "$rice"
done
