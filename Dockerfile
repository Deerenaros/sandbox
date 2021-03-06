FROM ubuntu:20.04

RUN export DEBIAN_FRONTEND=noninteractive && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    apt update && \
    apt-get install -y --no-install-recommends pandoc less golang docker curl jq wget tmux sudo vim htop man man-db openssh-client git remake make cmake gcc openssh-server shellinabox python3 python3-pip tree && \
    mkdir /workdir && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config && \
    groupadd guests && \
    useradd -ms /bin/bash -G sudo -g guests guest && \
    echo "guest:liquidcatonbatterythrust" | chpasswd && \
    ex +"%s/^%sudo.*$/%sudo ALL=(ALL:ALL) NOPASSWD:ALL/g" -scwq! /etc/sudoers && \
    yes | unminimize
RUN python3 -m pip install flask pandoc
RUN mkdir /run/sshd

WORKDIR /home/guest
RUN echo '[ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit; }' >> ./.bashrc && \
    echo 'setw -g remain-on-exit on' >> ./.tmux.conf
ADD . ./

RUN cd dublicates && ./generate.sh && rm -rf ./generate.sh

RUN mv ./docker-cmd.sh /bin/docker-cmd && chmod 755 /bin/docker-cmd && chown -R guest:guests ./*
RUN rm Dockerfile docker-compose.yaml
RUN git clone https://github.com/mbcrawfo/GenericMakefile.git makefiles
USER guest

CMD ["docker-cmd"]
