#!/usr/bin/bash

sudo /usr/sbin/sshd -Dp22 & /usr/bin/shellinaboxd --debug --disable-ssl
