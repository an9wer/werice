cdf() {
  declare -a dirs
  declare -i choice

  # Only directory is acceptable
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
      read -p "Which one is your choice? (1-${#dirs[@]}) " choice

      if (( $choice == 0 )); then
        echo "Choice cannot be characters or 0"
      elif (( $choice > ${#dirs[@]} )); then
        echo "Choice must be small than" ${#dirs[@]}
      else
        cd "${dirs[$choice - 1]}"
        break
      fi
    done
  fi
}
