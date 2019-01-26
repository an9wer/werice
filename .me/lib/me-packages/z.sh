if [[ $1 == install ]]; then
  me package install z

elif [[ $1 == update ]]; then
  me package update z

elif [[ $1 == remove ]]; then
  me package remove z

else
  [[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
fi
