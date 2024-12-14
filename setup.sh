#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

work_dir=$(dirname "$(realpath "$0")")
setup_list="$1"

cd "$work_dir"
mkdir -p ./init.d

# Sets debconf to use non-interactive mode for package installation
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update
apt-get full-upgrade -y

apt-get install -y --no-install-recommends \
  apt-utils \
  jq \
  netcat-traditional \
  net-tools

cat > /etc/profile.d/docker.sh << EOT
alias enable-xdebug='/srv/rctl.sh --enable-php-ext=xdebug'
alias disable-xdebug='/srv/rctl.sh --disable-php-ext=xdebug'
EOT

for setup in $(echo "$setup_list" | jq -r 'to_entries[] | "\(.key) \(.value)"' | sed 's/  */ /g;s/ /|/g'); do
  dir=$(echo "$setup" | cut -d'|' -f1)
  arg_list=$(echo "$setup" | cut -d'|' -f2- | sed 's/|/ /g')
  "./$dir/setup.sh" "$arg_list"
done

apt-get clean -y
