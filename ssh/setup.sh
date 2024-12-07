#!/bin/bash -e

work_dir="$1"
port=$(echo "$2" | awk '{print $1}')
start_script=$work_dir/start.sh
login_user='project'

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

useradd $login_user --comment 'Project' --create-home --shell /bin/bash
usermod -aG sudo $login_user
mkdir -p /home/$login_user/.ssh
chmod 700 /home/$login_user/.ssh
#touch /home/$login_user/.ssh/authorized_keys
#chmod 400 /home/$login_user/.ssh/authorized_keys
