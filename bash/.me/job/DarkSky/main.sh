# requirement
command -v JSON &> /dev/null || me addm JSON


# global variable
export ME_JOB_DARKSKY_DIR="${ME_JOB_DIR}/DarkSky"
export ME_JOB_DARKSKY_SH=${ME_JOB_DARKSKY_DIR}/DarkSky.sh
export ME_JOB_DARKSKY_LOG=${ME_JOB_DARKSKY_DIR}/DarkSky.log


case $1 in
  -c)
    [[ -e $2 ]] && export ME_JOB_DARKSKY_CONF=$2 || me warn "flle ($2) doesn't exists"
    bash ${ME_JOB_DARKSKY_SH} $* &>> ${ME_JOB_DARKSKY_LOG}
    ;;
  -l)
    less ${ME_JOB_DARKSKY_LOG}
    ;;
esac
