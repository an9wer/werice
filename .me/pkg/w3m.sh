# Installation
# -----------------------------------------------------------------------------
me_unset_w3m() {
  unset -f me_unset_w3m w3m
}


# The hack way
# -----------------------------------------------------------------------------
w3m() {
  http_proxy="http://127.0.0.1:1080/"  \
  https_proxy="http://127.0.0.1:1080/" \
  no_proxy="localhost,127.0.0.0/8,::1" \
    command w3m $@
}

declare -fx w3m
