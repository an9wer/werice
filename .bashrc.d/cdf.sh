shopt -s globstar

cdf() {
  declare -a dirs
  declare -i choice

  # filter out all directories
  for dir in "$@"; do
    if [[ -d $dir ]]; then
      dirs+=("$dir")
    fi
  done

  if (( ${#dirs[@]} == 0 )); then
    echo "No directory found"
  elif (( ${#dirs[@]} == 1 )); then
    cd "${dirs[0]}"
  else
    for idx in "${!dirs[@]}"; do
      printf "%s.\t%s\n" "$(( $idx + 1))" "${dirs[$idx]}"
    done
    while true; do
      read -e -p "Which one do you want to move into? (1-${#dirs[@]}) " choice

      if (( $choice >= 1 )) && (( $choice <= ${#dirs[@]} )); then
        cd "${dirs[$choice - 1]}"
        break
      fi
    done
  fi
}
