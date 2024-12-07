#!/bin/bash -e

work_dir="$1"
port="$2"
start_script=$work_dir/start.sh
#login_user='project'

apt-get install -y --no-install-recommends ssh sudo
mkdir -p /run/sshd

cat > /etc/ssh/sshd_config.d/docker.conf << EOT
Port $port
AddressFamily inet
EOT

cat > "$start_script" << EOT
#!/bin/bash -e

/usr/sbin/sshd -Def /etc/ssh/sshd_config
EOT

chmod 700 "$start_script"

# useradd $login_user --comment 'Project' --home /home/$login_user --shell /bin/bash
# usermod -aG sudo $login_user
# mkdir -p /home/$login_user/.ssh
