FROM ubuntu:20.04

RUN export DEBIAN_FRONTEND=noninteractive && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    apt update && \
    apt-get install -y --no-install-recommends docker curl wget tmux sudo vim htop man openssh-client git make cmake gcc openssh-server shellinabox python3 && \
    mkdir /workdir && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config && \
    groupadd guests && \
    useradd -ms /bin/bash -G sudo -g guests guest && \
    echo "guest:lampfaceupthepockertable" | chpasswd && \
    ex +"%s/^%sudo.*$/%sudo ALL=(ALL:ALL) NOPASSWD:ALL/g" -scwq! /etc/sudoers
RUN mkdir /run/sshd

USER guest
WORKDIR /home/guest
RUN echo '[ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit; }' >> ./.bashrc && \
    echo 'setw -g remain-on-exit on' >> ./.tmux.conf && \
    mkdir bash-dublicates
ADD . ./

WORKDIR /home/guest/bash-dublicates/
RUN ../generate.sh && rm -f ../generate.sh ../Dockerfile

WORKDIR /home/guest

CMD ["./docker-cmd.sh"]
