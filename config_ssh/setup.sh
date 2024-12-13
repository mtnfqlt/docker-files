#!/bin/bash -e

# shellcheck disable=SC1091
source ./include.src

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
AddressFamily inet
AuthorizedKeysFile $authorized_keys_file
EOT

init_script='./init.d/100_sshd.sh'

cat > "$init_script" << EOT
#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "\$0"

work_dir=\$(dirname "\$(realpath "\$0")")
authorized_keys_file='$authorized_keys_file'
login_user='$login_user'

cd "\$work_dir"
rm -f \$authorized_keys_file
find $ssh_dir -maxdepth 1 -type f -name '*.pub' -exec cat {} + >> \$authorized_keys_file
sed -i 's/^#umask 022$/umask 002/g' /home/\$login_user/.profile
usermod -aG www-data \$login_user
exec /usr/sbin/sshd -Def /etc/ssh/sshd_config
EOT

chmod 700 "$init_script"
mkdir -p /run/sshd
