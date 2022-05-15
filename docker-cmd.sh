#!/usr/bin/bash

sudo /usr/sbin/sshd -Dp22 & \
/usr/bin/shellinaboxd --debug --disable-ssl &\
cd requests && ls &&  FLASK_APP=server flask run
