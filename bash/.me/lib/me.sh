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

    lsm)
      for mod_name in $(ls ${ME_MODULE_DIR}); do
        if [[ -L "${ME_BASHRC_DIR}/${mod_name}" ]]; then
          printf "%-20s${BOLD}${BLUE}%s${END}\n" "${mod_name%\.sh}" "enable"
        else
          printf "%-20s${BOLD}${RED}%s${END}\n" "${mod_name%\.sh}" "disable"
        fi
      done
      ;;

    addm)  
      local module
      for module in $@; do
        local install=me_install_${module}

        if [[ -e ${ME_MODULE_DIR}/${module}.sh ]]; then
          # create links to 'module' directory scripts in 'bashrc.d' directory
          ln -sf ${ME_MODULE_DIR}/${module}.sh ${ME_BASHRC_DIR}/${module}.sh &&
            source ${ME_BASHRC_DIR}/${module}.sh &&
            me prompt "create links to ${module} in 'bashrc.d' directory"

          # module hasn't been installed but has install function
          ! which ${module} &> /dev/null && command -v ${install} &> /dev/null && {
            eval ${install} && me prompt "successfully install ${module}"
          } || me warn "${module} may be installed by system package manager or a built-in command."

        else
          me warn "${module} doesn't exist in module directory."
        fi
      done
      ;;

    delm) 
      local module
      for module in $@; do
        local uninstall=me_uninstall_${module} unset=me_unset_${module}

        # module command cannot be found
        if ! command -v ${module} &> /dev/null; then
          me warn "${module} hasn't been installed :("
          return 1
        fi

        # module command can be found in 'ME_BIN_DIR'
        if command -v ${uninstall} &> /dev/null; then
          eval ${uninstall}
        else
          local warning="${module} may be installed by system package manager "
          local warning+="or a builtin command. "
          local warning+="we'll just remove module's symbolic file in 'bashrc.d'"
          me warn ${warning}
        fi

        # remove module.sh which is in 'bashrc.d' directory
        [[ -L ${ME_BASHRC_DIR}/${module}.sh ]] &&
        rm ${ME_BASHRC_DIR}/${module}.sh &&
        me prompt "successfully remove module's symbolic file in 'bushrc.d'" ||
        me warn "${module} doesn't exist or can't be removed (not a symbolic file)."

        # unset all variables in module
        command -v ${unset} &> /dev/null && {
          eval ${unset} && me prompt "unset all variables in ${module}"
        }

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

_me_completion() {
  local pre="${COMP_WORDS[COMP_CWORD - 1]}"
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local opt="lsm addm delm job"
  local mod_name job_name
  COMPREPLY=()
  case ${pre} in
    me)
      COMPREPLY=($(compgen -W "${opt}" -- ${cur}))
      ;;
    addm)
      for mod_name in $(ls ${ME_MODULE_DIR}); do
        [[ ! -L "${ME_BASHRC_DIR}/${mod_name}" && ${mod_name} =~ ^${cur} ]] && {
          COMPREPLY+=(${mod_name%.sh})
        }
      done
      ;;
    delm)
      for mod_name in $(ls ${ME_MODULE_DIR}); do
        [[ -L "${ME_BASHRC_DIR}/${mod_name}" && "${mod_name}" =~ ^${cur} ]] && {
            COMPREPLY+=(${mod_name%.sh})
        }
      done
      ;;
    job)
      for job_name in $(ls ${ME_JOB_DIR}); do
        [[ "${job_name}" =~ ^${cur} ]] && COMPREPLY+=(${job_name%.sh})
      done
      ;;
    -*)
      COMPREPLY=($(compgen -fd ${cur}))
      ;;
  esac
}


# we should to export function 'me', so that we can call it from subshell
declare -fx me
# completion for me
complete -o filenames -F _me_completion me
