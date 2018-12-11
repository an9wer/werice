me() {
  local first=$1
  shift

  case $first in
    list)
      for mod_name in $(ls ${ME_PKG_DIR}); do
        if [[ -L "${ME_BASHRC_DIR}/${mod_name}" ]]; then
          printf "%-20s${ME_ANSI_BOLD}${ME_ANSI_BLUE}%s${ME_ANSI_END}\n" "${mod_name%\.sh}" "enable"
        else
          printf "%-20s${ME_ANSI_BOLD}${ME_ANSI_RED}%s${ME_ANSI_END}\n" "${mod_name%\.sh}" "disable"
        fi
      done
      ;;

    install)  
      local pkg
      for pkg in $@; do
        local install=me_install_${pkg}

        if [[ -e ${ME_PKG_DIR}/${pkg}.sh ]]; then
          # create links to 'pkg' directory scripts in 'bashrc.d' directory
          ln -sf ${ME_PKG_DIR}/${pkg}.sh ${ME_BASHRC_DIR}/${pkg}.sh &&
            source ${ME_BASHRC_DIR}/${pkg}.sh &&
            me_info "create symbolic file '${pkg}.sh' in 'bashrc.d'"

          # pkg hasn't been installed but has install function
          ! which ${pkg} &> /dev/null && command -v ${install} &> /dev/null && {
            eval ${install} && me_info "successfully install '${pkg}'"
          } || me_warn "${pkg} may be installed by system package manager or a built-in command."

        else
          me_warn "'${pkg}' doesn't exist in directory '${ME_PKG_DIR}'."
        fi
      done
      ;;

    remove) 
      local pkg
      for pkg in $@; do
        local uninstall=me_uninstall_${pkg} unset=me_unset_${pkg}

        # pkg command cannot be found
        if ! command -v ${pkg} &> /dev/null; then
          me_warn "${pkg} hasn't been installed :("
          return 1
        fi

        # pkg command can be found in 'ME_BIN_DIR'
        if command -v ${uninstall} &> /dev/null; then
          eval ${uninstall}
        else
          local warning="'${pkg}' may be installed by system package manager "
          local warning+="or a builtin command. "
          local warning+="we'll just remove the symbolic file '${pkg}.sh' in 'bashrc.d'"
          me_warn ${warning}
        fi

        # remove pkg.sh which is in 'bashrc.d' directory
        [[ -L ${ME_BASHRC_DIR}/${pkg}.sh ]] &&
        rm ${ME_BASHRC_DIR}/${pkg}.sh &&
        me_info "successfully remove the symbolic file '${pkg}.sh' in 'bushrc.d'" ||
        me_warn "'${pkg}' doesn't exist or can't be removed (not be a symbolic file)."

        # unset all variables in pkg
        command -v ${unset} &> /dev/null && {
          eval ${unset} && me_info "unset all variables in '${pkg}.sh'"
        }

      done
      ;;

    job)
      if [[ -d "${ME_JOB_DIR}/$1" ]]; then
        bash "${ME_JOB_DIR}/$1/main.sh" ${@:2}
      else
        me_warn "The job '$1' doesn't exist"
      fi
      ;;
    *)
      echo \
        'Usage: me <command> [<args>]'            $'\n' \
        ''                                        $'\n' \
        'All commands:'                           $'\n' \
        '  list     list all avaliable packages'  $'\n' \
        '  install  install packages'             $'\n' \
        '  remove   remove packages'              $'\n' \
        '  job      make some job'
      ;;
  esac
}

_me_completion() {
  local pre="${COMP_WORDS[COMP_CWORD - 1]}"
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local opt="list install remove job"
  local mod_name job_name
  COMPREPLY=()
  case ${pre} in
    me)
      COMPREPLY=($(compgen -W "${opt}" -- ${cur}))
      ;;
    install)
      for mod_name in $(ls ${ME_PKG_DIR}); do
        [[ ! -L "${ME_BASHRC_DIR}/${mod_name}" && ${mod_name} =~ ^${cur} ]] && {
          COMPREPLY+=(${mod_name%.sh})
        }
      done
      ;;
    remove)
      for mod_name in $(ls ${ME_PKG_DIR}); do
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


# Export function `me` to call it from subshell
declare -fx me
# completion for me
complete -o filenames -F _me_completion me
