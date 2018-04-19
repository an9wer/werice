# create links to 'module' directory scripts in 'bashrc.d' directory
me::addm() {
  for module in $@; do
    if [[ -e ${ME_MODULE_DIR}/${module}.sh ]]; then
      ln -sf ${ME_MODULE_DIR}/${module}.sh ${ME_BASHRC_DIR}/${module}.sh
      source ${ME_BASHRC_DIR}/${module}.sh
    else
      echo "${module} doesn't exist in module directory."
    fi
  done
}

# remove module links in 'bashrc.d' directory
me::delm() {
  for module in $@; do
    if [[ -L ${ME_BASHRC_DIR}/${module}.sh ]]; then
      rm -i ${ME_BASHRC_DIR}/${module}.sh
    else
      echo "${module} doesn't exist or can't be removed (not a symbolic file)."
    fi
  done
}

me::job() {
  if [[ -e "${ME_JOB_DIR}/$1.sh" ]]; then
    bash "${ME_JOB_DIR}/$1.sh"
  else
    echo "$1 doesn't exist"
  fi
}


me() {
  case $1 in
    addm)  
      me::addm ${@:2}
      ;;
    delm) 
      me::delm ${@:2}
      ;;
    job)
      me::job ${@:2}
      ;;
    *)
      echo "TODO: help"
      ;;
  esac
}

# need to export function 'me', then we can call it from subshell
declare -fx me
