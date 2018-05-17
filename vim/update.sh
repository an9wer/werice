BUNDLE=~/.vim/bundle

update() {
  local dir=${BUNDLE}/$1
  [[ -d ${dir} ]] && cd $dir && git pull && echo "updated: ${dir}"
}

for plug in $(ls ${BUNDLE}); do
  update ${plug}
done
