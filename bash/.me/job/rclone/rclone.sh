alert() {
  # to send desktop notification from a background script (for cron)
  #local DISPLAY=:0
  #local DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
  local msg
  case $1 in
    suc)
      msg="success to synchronous from '${from}' to '${to}'\n"
      msg+="file:///${ME_JOB_RCONLE_LOG}"
      notify-send -u low "rclone" "${msg}"
      ;;
    err)
      msg="fail to synchronous from '${from}' to '${to}'"
      msg+="file:///${ME_JOB_RCONLE_LOG}"
      notify-send -u critical "rclone" "${msg}"
      ;;
  esac
  echo ${msg}
}

synchronous() {
  rclone check ${from} ${to} && alert suc || alert err
}

# main
# -----------------------------------------------------------------------------
synchronous
