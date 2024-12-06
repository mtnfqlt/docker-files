#!/bin/bash -e

start_script='/srv/start.sh'

apt-get install -y --no-install-recommends ssh

cat > $start_script << EOT
#!/bin/bash -x

/usr/sbin/sshd -D -e -f /etc/ssh/sshd_config
sleep 3600
EOT

chmod 700 $start_script
