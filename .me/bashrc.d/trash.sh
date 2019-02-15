trash() {
  local trash
  local trash_dir=~/.trash

  local -i ctime
  local -i now=$(date +%s)
  local -i interval=30*24*60*60   # 30 days

  [[ ! -d $trash_dir ]] && mkdir "$trash_dir"

  # Remove expired trash files
  IFS=$'\n'
  for trash in $(ls "$trash_dir"); do
    ctime=$(stat --format=%Z "$trash_dir/$trash")
    (( $now - $ctime > $interval )) && rm -rf "$trash_dir/$trash"
  done

  mv -i "$@" "$trash_dir"
}
