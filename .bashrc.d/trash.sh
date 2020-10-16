trash() {
  local trash
  local trashdir=~/Trash

  local -i ctime
  local -i now=$(date +%s)
  local -i interval=30*24*60*60   # 30 days

  if [[ ! -d $trashdir ]]; then
    mkdir -p "$trashdir"
  fi

  # Remove expired trash files
  IFS=$'\n'
  for trash in $(ls "$trashdir"); do
    ctime=$(stat --format=%Z "$trashdir/$trash")
    if (( $now - $ctime > $interval )); then
      rm -rf "$trashdir/$trash"
    fi
  done

  mv -i "$@" "$trashdir"
}
