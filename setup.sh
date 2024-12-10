#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

setup_list="$1"

# Sets debconf to use non-interactive mode for package installation
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update
apt-get full-upgrade -y
apt-get install -y --no-install-recommends apt-utils jq

#for setup in $(echo "$setup_list" | jq -r 'to_entries[] | "\(.key) \(.value)"' | sed 's/* = */=/;s/  */ /g;s/ *$//;s/ /|/g'); do
for setup in $(echo "$setup_list" | jq -r 'to_entries[] | "\(.key) \(.value)"' | sed "s/  */ /g;s/' */'/g;s/* '/'/g;s/ /|/g"); do
  dir=$(echo "$setup" | cut -d'|' -f1)
  arg_list=$(echo "$setup" | cut -d'|' -f2- | sed 's/|/ /g')
  echo "$dir"
  echo "$arg_list"
  #"./$dir/setup.sh" "$arg_list"
done
