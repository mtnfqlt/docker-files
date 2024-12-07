#!/bin/bash -e

repo_url="$1"
branch="$2"
setup_list="$3"
pre_setup_script="$4"
post_setup_script="$5"

echo "$repo_url"
echo "$branch"
echo "$setup_list"
echo "$pre_setup_script"
echo "$post_setup_script"


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
