#!/bin/bash -e

start_script='/srv/start.sh'

apt-get install -y --no-install-recommends ssh

cat > $start_script << EOT
#!/bin/bash -x

mkdir -p /var/run/sshd
/usr/sbin/sshd -D -e -f /etc/ssh/sshd_config
EOT

chmod 700 $start_script
