# global variable
export ME_JOB_RCLONE_DIR=${ME_JOB_DIR}/rclone
export ME_JOB_RCLONE_SH=${ME_JOB_RCLONE_DIR}/rclone.sh
export ME_JOB_RCONLE_LOG=${ME_JOB_RCLONE_DIR}/rclone.log
export ME_JOB_RCLONE_CONF="~/.config/me/rclone.conf"

while getopts ":c:f:t:l" opt; do
  case ${opt} in
    c) conf=${OPTARG} ;;
    f) from=${OPTARG} ;;
    t) to=${OPTARG} ;;
    l) less ${ME_JOB_RCONLE_LOG} && exit 0 ;;
    ?) echo "invalid option '-${OPTARG}'" && exit 1 ;;
  esac
done

# redirect output to log file and standard output
# thx: https://stackoverflow.com/a/3403786
# thx: https://stackoverflow.com/a/11886837
exec > >(tee -ai ${ME_JOB_RCONLE_LOG})
exec 2>&1

echo -------------------- $(date +"%Y/%m/%d %H:%M:%S") --------------------

[[ -e "${conf:-${ME_JOB_RCLONE_CONF}}" ]] && . ${conf:-${ME_JOB_RCLONE_CONF}}

[[ -z "${from}" || -z "${to}" ]] && {
  echo "can't get enough config info"
  exit 1;
}

. ${ME_JOB_RCLONE_SH}
