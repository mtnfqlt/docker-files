#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

setup_list="$1"

install_php_mod() {
  echo "$2"
  pecl install "$2"
}

# Sets debconf to use non-interactive mode for package installation
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update
apt-get full-upgrade -y
apt-get install -y --no-install-recommends apt-utils jq

echo "$setup_list" | jq -r 'to_entries[] | "\(.key) \(.value)"' | while read -r dir zarg; do
  #"./$dir/setup.sh" "$arg"
  echo "$dir"
  echo "$zarg"
  "$dir" $zarg
done
