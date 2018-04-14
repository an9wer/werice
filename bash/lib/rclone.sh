rclone() {
  export http_proxy="http://127.0.0.1:1080/"
  export https_proxy="http://127.0.0.1:1080/"
  export no_proxy="localhost,127.0.0.0/8,::1"
  command rclone $@
  unset http_proxy https_proxy no_proxy
}
