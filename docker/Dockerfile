FROM base/archlinux

LABEL maintainer.name="an9wer"
LABEL maintainer.email="an9wer@gmail.com"

SHELL ["/bin/bash", "-c"]

USER root:root
ENV ROOT_STARTUP /root/startup
COPY --chown=root:root root_startup/set_*.sh ${ROOT_STARTUP}/
RUN pacman -Syu --noconfirm
RUN ${ROOT_STARTUP}/set_timezone.sh
RUN ${ROOT_STARTUP}/set_locale.sh
RUN ${ROOT_STARTUP}/set_user.sh
RUN ${ROOT_STARTUP}/set_ssh.sh
RUN ${ROOT_STARTUP}/set_basic_tools.sh

USER an9wer:wheel
ENV AN9WER_STARTUP /home/an9wer/startup
COPY --chown=an9wer:wheel an9wer_startup/set_*.sh ${AN9WER_STARTUP}/
RUN ${AN9WER_STARTUP}/set_dotfiles.sh

EXPOSE 22
