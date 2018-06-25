FROM base/archlinux

LABEL maintainer.name="an9wer"
LABEL maintainer.email="an9wer@gmail.com"

USER root:root
SHELL ["/bin/bash", "-c"]

COPY --chown=root:root set_*.sh /root/

RUN pacman -Syu --noconfirm
#RUN for script in $(ls /root/set_*.sh); do ${script}; done
RUN /root/set_timezone.sh
RUN /root/set_locale.sh
RUN /root/set_ssh.sh
RUN /root/set_dotfiles.sh
RUN /root/set_tldr.sh

EXPOSE 22
