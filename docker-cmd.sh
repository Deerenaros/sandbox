#!/usr/bin/bash

sudo /usr/sbin/sshd -Dp22 & \
ttyd -p 4200 bash & \
cd requests && FLASK_APP=server flask run
