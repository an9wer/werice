BUNDLE=~/.vim/bundle

install() {
  local dir=${BUNDLE}/${1##*/}
  ! [[ -d ${dir} ]] && git clone --depth 1 https://github.com/${1}.git ${dir} || echo "${dir}"
}

# NERDTree
install "scrooloose/nerdtree"
# fzf
install "junegunn/fzf.vim"
# smooth scroll
install "yonchu/accelerated-smooth-scroll"
