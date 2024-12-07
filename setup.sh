#!/bin/bash -e

echo "$1"
echo "$2"
echo "$3"
echo "$4"
echo "$5"

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
