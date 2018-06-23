install_depedence() {
  pacman -Sy --noconfirm git man vim
}

download_dotfiles() {
  mkdir ~/Naruto && cd ~/Naruto
  git clone https://github.com/an9wer/mydotfiles.git
}

install_dotfiles() {
  ~/Naruto/mydotfiles/bash/install.sh
}

install_depedence && download_dotfiles && install_dotfiles
