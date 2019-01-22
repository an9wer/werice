FROM base/archlinux

LABEL maintainer.name="an9wer"
LABEL maintainer.email="an9wer@gmail.com"

SHELL ["/bin/bash", "-c"]

USER root:root
ENV SETUP /root/setup
COPY --chown=root:root setup/*.sh ${SETUP}/
RUN pacman -Syu --noconfirm
RUN ${SETUP}/timezone.sh
RUN ${SETUP}/locale.sh
RUN ${SETUP}/ssh.sh
RUN ${SETUP}/user.sh
RUN ${SETUP}/basetools.sh

USER an9wer:wheel

EXPOSE 22
