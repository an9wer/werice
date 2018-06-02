# requirement
command -v JSON &> /dev/null || me addm JSON


# global variable
export ME_JOB_DARKSKY_DIR=${ME_JOB_DIR}/DarkSky
export ME_JOB_DARKSKY_SH=${ME_JOB_DARKSKY_DIR}/DarkSky.sh
export ME_JOB_DARKSKY_LOG=${ME_JOB_DARKSKY_DIR}/DarkSky.log
export ME_JOB_DARKSKY_CONF="~/.config/me/DarkSky.conf"


case $1 in
  -c)
    # usage: me job DarkSky -c DarkSky.conf
    [[ -e "$2" ]] &&
      export ME_JOB_DARKSKY_CONF=$2 ||
      { me warn "config flle ($2) doesn't exists"; exit; }
    bash ${ME_JOB_DARKSKY_SH} &>> ${ME_JOB_DARKSKY_LOG}
    ;;
  -l)
    # usage: me job DarkSky -l
    less ${ME_JOB_DARKSKY_LOG}
    ;;
  *)
    bash ${ME_JOB_DARKSKY_SH} &>> ${ME_JOB_DARKSKY_LOG}
    ;;
esac
