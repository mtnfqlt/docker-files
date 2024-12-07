#!/bin/bash -e

work_dir=$(dirname "$(realpath "$1")")
#port="$2"
start_script=$work_dir/start.sh
#login_user='project'
echo "$start_script"
apt-get install -y --no-install-recommends ssh sudo

cat > "$start_script" << EOT
#!/bin/bash -e

mkdir -p /run/sshd
/usr/sbin/sshd -Def /etc/ssh/sshd_config
EOT

chmod 700 "$start_script"

# useradd $login_user --comment 'Project' --home /home/$login_user --shell /bin/bash
# usermod -aG sudo $login_user
# mkdir -p /home/$login_user/.ssh
