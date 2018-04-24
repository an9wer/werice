me() {
  case $1 in
    addm)  
      shift
      for module in $@; do
        if [[ -e ${ME_MODULE_DIR}/${module}.sh ]]; then
          # create links to 'module' directory scripts in 'bashrc.d' directory
          ln -sf ${ME_MODULE_DIR}/${module}.sh ${ME_BASHRC_DIR}/${module}.sh
          source ${ME_BASHRC_DIR}/${module}.sh
          if type "me::install_${module}" &> /dev/null; then
              eval "me::install_${module}"
          fi
        else
          echo "${module} doesn't exist in module directory."
        fi
      done
      ;;
    delm) 
      shift
      for module in $@; do
        if [[ -L ${ME_BASHRC_DIR}/${module}.sh ]]; then
          if type "me::uninstall_${module}" &> /dev/null; then
            eval "me::uninstall_${module}"
          fi
          # remove module links in 'bashrc.d' directory
          rm -i ${ME_BASHRC_DIR}/${module}.sh
        else
          echo "${module} doesn't exist or can't be removed (not a symbolic file)."
        fi
      done
      ;;
    job)
      shift
      if [[ -e "${ME_JOB_DIR}/$1.sh" ]]; then
        bash "${ME_JOB_DIR}/$1.sh" ${@:2}
      else
        echo "$1 doesn't exist"
      fi
      ;;
    *)
      echo "TODO: help"
      ;;
  esac
}

# need to export function 'me', then we can call it from subshell
declare -fx me
