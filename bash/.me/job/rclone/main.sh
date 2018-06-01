# global variable
export ME_JOB_RCLONE_DIR=${ME_JOB_DIR}/rclone
export ME_JOB_RCLONE_SH=${ME_JOB_RCLONE_DIR}/rclone.sh
export ME_JOB_RCONLE_LOG=${ME_JOB_RCLONE_DIR}/rclone.log
export ME_JOB_RCLONE_CONF=""


case $1 in
  -c)
    # usage: me job rclone -c rclone.conf
    [[ -e "$2" ]] &&
      export ME_JOB_RCLONE_CONF=$2 ||
      { me warn "config flle ($2) doesn't exists"; exit; }
    bash ${ME_JOB_RCLONE_SH} &>> ${ME_JOB_RCONLE_LOG}
    ;;
  -l)
    # usage: me job rclone -l
    less ${ME_JOB_RCONLE_LOG}
    ;;
esac
