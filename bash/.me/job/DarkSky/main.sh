# requirement
command -v JSON &> /dev/null || me addm JSON


# global variable
export ME_JOB_DARKSKY_DIR="${ME_JOB_DIR}/DarkSky"
export ME_JOB_DARKSKY_SH=${ME_JOB_DARKSKY_DIR}/DarkSky.sh
export ME_JOB_DARKSKY_CONF=${ME_JOB_DARKSKY_DIR}/DarkSky.conf
export ME_JOB_DARKSKY_LOG=${ME_JOB_DARKSKY_DIR}/DarkSky.log

bash ${ME_JOB_DARKSKY_SH} $* &>>${ME_JOB_DARKSKY_LOG}
