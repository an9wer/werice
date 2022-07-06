#!/bin/bash -e

# backup original files if needed
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

# link rice file to target path
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
    echo "Error: '$rice' is not a file or a directory."
    return 1
  fi

  backup-origin "$rice"
  install-rice "$rice"
done
