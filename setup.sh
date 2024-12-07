#!/bin/bash -e

port="$1"
repo_url="$2"
branch="$3"
setup_list="$4"
pre_setup_script="./$5"
post_setup_script="./$6"

echo "$port"
echo "$repo_url"
echo "$branch"
echo "$setup_list"
echo "$pre_setup_script"
echo "$post_setup_script"

apt-get update
apt-get full-upgrade -y
apt-get install -y --no-install-recommends curl


if [ -f "$pre_setup_script" ]; then $pre_setup_script; fi

if [ -f "$post_setup_script" ]; then $post_setup_script; fi

# repo_url='https://raw.githubusercontent.com/mtnfqlt/docker-files/refs/heads/main'

# setup_list='
#   tools
#   ssh'

# # Sets debconf to use non-interactive mode for package installation
# echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# apt-get update
# apt-get install -y --no-install-recommends ca-certificates wget

# for setup in $setup_list; do
#   wget -O - "$repo_url/$setup/setup.sh" | bash
# done
