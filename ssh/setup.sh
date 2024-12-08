#!/bin/bash -e

work_dir="$1"
port=$(echo "$2" | awk '{print $1}')
start_script=$work_dir/start.sh

apt-get install -y --no-install-recommends ssh sudo

login_user='project'
useradd $login_user --comment 'Project' --create-home --shell /bin/bash
usermod -aG sudo $login_user
echo "$login_user ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$login_user"
chmod 440 /etc/sudoers.d/$login_user

ssh_dir=/home/$login_user/.ssh
mkdir -p $ssh_dir
chmod 700 $ssh_dir

authorized_keys_file='/etc/ssh/authorized_keys'

cat > /etc/ssh/sshd_config.d/docker.conf << EOT
Port $port
AddressFamily inet
AuthorizedKeysFile $authorized_keys_file
EOT

cat > "$start_script" << EOT
#!/bin/bash -e

authorized_keys_file='$authorized_keys_file'

rm -f \$authorized_keys_file
find $ssh_dir -maxdepth 1 -type f -name '*.pub' -exec cat {} + >> \$authorized_keys_file
ip route get 8.8.8.8 | awk '{print $7}'
/usr/sbin/sshd -Def /etc/ssh/sshd_config
EOT

chmod 700 "$start_script"
mkdir -p /run/sshd
