FROM base/archlinux

LABEL maintainer.name="an9wer"
LABEL maintainer.email="an9wer@gmail.com"

USER root:root
SHELL ["/bin/bash", "-c"]

COPY --chown=root:root set_*.sh /root/

RUN pacman -Syu --noconfirm
RUN /root/set_ssh.sh
RUN /root/set_dotfiles.sh

EXPOSE 22
