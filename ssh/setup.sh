#!/bin/bash -e

start_script='/srv/start.sh'
login_user='project'

apt-get install -y --no-install-recommends ssh sudo

cat > $start_script << EOT
#!/bin/bash -e

mkdir -p /var/run/sshd
/usr/sbin/sshd -D -e -f /etc/ssh/sshd_config
EOT

chmod 700 $start_script

useradd $login_user --comment 'Project' --home /home/$login_user --shell /bin/bash
usermod -aG sudo $login_user
mkdir -p /home/$login_user/.ssh
