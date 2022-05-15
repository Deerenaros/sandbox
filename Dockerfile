FROM ubuntu:20.04

RUN export DEBIAN_FRONTEND=noninteractive && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    apt update && \
    apt-get install -y --no-install-recommends pandoc less golang docker curl jq wget tmux sudo vim htop man openssh-client git make cmake gcc openssh-server shellinabox python3 python3-pip tree && \
    mkdir /workdir && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config && \
    groupadd guests && \
    useradd -ms /bin/bash -G sudo -g guests guest && \
    echo "guest:lampfaceupthepockertable" | chpasswd && \
    ex +"%s/^%sudo.*$/%sudo ALL=(ALL:ALL) NOPASSWD:ALL/g" -scwq! /etc/sudoers
RUN python3 -m pip install flask pandoc
RUN mkdir /run/sshd

WORKDIR /home/guest
RUN echo '[ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit; }' >> ./.bashrc && \
    echo 'setw -g remain-on-exit on' >> ./.tmux.conf
ADD . ./

RUN cd dublicates && ./generate.sh && rm -rf ./generate.sh

RUN mv ./docker-cmd.sh /bin/docker-cmd && chmod 755 /bin/docker-cmd && chown -R guest:guests ./*
RUN rm Dockerfile docker-compose.yaml
USER guest

CMD ["docker-cmd"]

# curl localhost:5000/api/token | jq -r .token
# curl -X POST -d 'key=asdf&content=helloworld' localhost:5000/api/$(curl localhost:5000/api/token | jq -r .token)/add
# curl -X POST -d 'key=ASDF&content=helloworld' localhost:5000/api/1JLJXIYHUXBYNQ1T/add