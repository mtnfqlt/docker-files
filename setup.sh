#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

work_dir=$(dirname "$(realpath "$0")")
setup_list="$1"

cd "$work_dir"

# Sets debconf to use non-interactive mode for package installation
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update
apt-get full-upgrade -y
apt-get install -y --no-install-recommends apt-utils jq

setup_list=$(echo "$setup_list" | \
              jq -r 'to_entries[] | if .value == null then "\(.key)" else "\(.key) \(.value)' | \
              sed "s/  */ /g;s/ /|/g")

for setup in $setup_list; do
  dir=$(echo "$setup" | cut -d'|' -f1)
  arg_list=$(echo "$setup" | cut -d'|' -f2- | sed 's/|/ /g')
  "./$dir/setup.sh" "$arg_list"
done
