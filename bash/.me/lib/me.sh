me() {
  local BOLD="\e[1m"
  local BLUE="\e[34m"
  local RED="\e[91m"
  local END="\e[0m"

  local first=$1
  shift

  case $first in
    prompt)
      printf "${BOLD}${BLUE}%s${END}\n" "$*"
      ;;

    warn)
      printf "${BOLD}${RED}%s${END}\n" "$*"
      ;;

    addm)  
      local module
      for module in $@; do
        if which ${module} &> /dev/null; then
          me prompt "${module} has been installed :)"
          return 0
        fi

        if [[ -e ${ME_MODULE_DIR}/${module}.sh ]]; then
          # create links to 'module' directory scripts in 'bashrc.d' directory
          ln -sf ${ME_MODULE_DIR}/${module}.sh ${ME_BASHRC_DIR}/${module}.sh
          source ${ME_BASHRC_DIR}/${module}.sh

          type "me_install_${module}" &> /dev/null && eval "me_install_${module}"
        else
          me warn "${module} doesn't exist in module directory."
        fi
      done
      ;;

    delm) 
      local module
      for module in $@; do
        if ! which ${module} &> /dev/null; then
          me warn "${module} hasn't been installed :("
          return 1
        fi

        if [[ ! $(which ${module}) == ${ME_BIN_DIR}/${module} ]]; then
          me warn "${module} may be installed by your system package manager."
          return 1
        fi

        if [[ -L ${ME_BASHRC_DIR}/${module}.sh ]]; then
          type "me_uninstall_${module}" &> /dev/null &&
          eval "me_uninstall_${module}" &&
          rm ${ME_BASHRC_DIR}/${module}.sh # remove module links in 'bashrc.d' directory
        else
          me warn "${module} doesn't exist or can't be removed (not a symbolic file)."
        fi
      done
      ;;

    job)
      if [[ -d "${ME_JOB_DIR}/$1" ]]; then
        bash "${ME_JOB_DIR}/$1/main.sh" ${@:2}
      else
        me warn "The job '$1' doesn't exist"
      fi
      ;;
    *)
      echo "TODO: help"
      ;;
  esac
}

# need to export function 'me', then we can call it from subshell
declare -fx me
