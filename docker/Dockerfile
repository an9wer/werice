FROM base/archlinux

LABEL maintainer.name="an9wer"
LABEL maintainer.email="an9wer@gmail.com"

SHELL ["/bin/bash", "-c"]

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm openssh man git vim

# thx: https://github.com/retorillo/archlinux-sshd/blob/master/Dockerfile
RUN [[ ! -f /etc/ssh/ssh_host_rsa_key ]] && ssh-keygen -A
RUN /bin/sshd

EXPOSE 22
