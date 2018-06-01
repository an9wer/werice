alert() {
  # to send desktop notification from a background script (for cron)
  #local DISPLAY=:0
  #local DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
  local msg
  case $1 in
    suc)
      msg="success to synchronous from '${from}' to '${to}'"
      notify-send -u low "rclone" "${msg}"
      ;;
    err)
      msg="fail to synchronous from '${from}' to '${to}'"
      notify-send -u critical "rclone" "${msg}"
      ;;
  esac
  printf "$(date)    %s\n" "${msg}"
}

synchronous() {
  rclone copy ${from} ${to} && alert suc || alert err
}

# main
# -----------------------------------------------------------------------------
# read variable from config file
echo $(pwd) "${ME_JOB_RCLONE_CONF}"
[[ -e "${ME_JOB_RCLONE_CONF}" ]] && . ${ME_JOB_RCLONE_CONF} ||
  { me warn "config flle '${ME_JOB_RCLONE_CONF}' doesn't exists"; exit; }

synchronous
