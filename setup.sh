#!/bin/bash -e

setup_list="$1"

# Sets debconf to use non-interactive mode for package installation
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update
apt-get full-upgrade -y
apt-get install -y --no-install-recommends apt-utils jq

echo "$setup_list" | jq -r 'to_entries[] | "\(.key) \(.value)"' | while read -r key value; do
  "./$key/setup.sh $value"
done
