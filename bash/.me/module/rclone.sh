ME_LIB_RCLONE_DIR=${ME_LIB_DIR}/rclone


# installation (thx: https://rclone.org/install.sh)
# -----------------------------------------------------------------------------
me::install_rclone() {
  if [[ ! -d ${ME_LIB_RCLONE_DIR} ]]; then
    echo "start to install rclone..."

    # detect the platform (only in linux)
    local ME_MACHINE=$(uname -m)
    case $ME_MACHINE in
      x86_64|amd64) ME_MACHINE=amd64;;
      i?86|x86) ME_MACHINE=386;;
      *) echo "cannnot install rclone"; return 1;;
    esac

    # create temporary file
    local zip_file=$(mktemp -t --suffix='.zip' rclone.XXX)
    local unzip_dir=$(mktemp -t -d rclone.XXX)

    # download rclone zip file
    curl https://downloads.rclone.org/rclone-current-linux-${ME_MACHINE}.zip -o ${zip_file}

    # extract rclone zip file and move it into 'lib' directory
    unzip ${zip_file} -d ${unzip_dir} &> /dev/null
    mv ${unzip_dir}/rclone-*-linux-${ME_MACHINE} ${ME_LIB_RCLONE_DIR}

    chmod 755 ${ME_LIB_DIR}/rclone/rclone
    ln -sf "${ME_LIB_RCLONE_DIR}/rclone" ${ME_BIN_DIR}/rclone
    ln -sf ${ME_LIB_RCLONE_DIR}/rclone.1 ${ME_MAN_DIR}/man1/rclone.1
    mandb &> /dev/null
  fi
}

me::install_rclone


# usage
# -----------------------------------------------------------------------------
rclone() {
  export http_proxy="http://127.0.0.1:1080/"
  export https_proxy="http://127.0.0.1:1080/"
  export no_proxy="localhost,127.0.0.0/8,::1"
  command rclone $@
  unset http_proxy https_proxy no_proxy
}
