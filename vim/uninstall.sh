BUNDLE=~/.vim/bundle

remove() {
  local dir=${BUNDLE}/$1
  [[ -d ${dir} ]] && rm -rf ${dir} && echo "removed: ${dir}"
}

if (( ${#@} == 0 )); then
  # remove all plugin in bundle
  for plug in $(ls ${BUNDLE}); do
    remove ${plug}
  done
else
  # remove selected plugin in bundle
  for plug in ${@}; do
    remove ${plug}
  done
fi 
