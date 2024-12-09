#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

setup_list="$1"

install_php_mod() {
  echo "$2"
  pecl install redis-6.1.0
}

# Sets debconf to use non-interactive mode for package installation
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update
apt-get full-upgrade -y
apt-get install -y --no-install-recommends apt-utils jq

echo "$setup_list" | jq -r 'to_entries[] | "\(.key) \(.value)"' | \
while read -r key value; do
  echo "$key"
  echo "$value"
  #install_php_mod $value
  pecl install redis-6.1.0
done

# | while read -r ddir zarg; do
#   #"./$dir/setup.sh" "$arg"
#   echo "$ddir"
#   echo "$zarg"
#   "$ddir" $zarg
# done
