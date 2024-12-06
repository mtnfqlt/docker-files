#!/bin/bash -e

start_script='/srv/start.sh'

apt-get install -y --no-install-recommends ssh
echo 'sshd -D -e -f /etc/ssh/sshd_config' > $start_script
chmod 700 $start_script
