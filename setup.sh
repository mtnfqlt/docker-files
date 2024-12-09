#!/bin/bash -e

setup_list="$1"

install_tools() {
  echo "$1"
}

create_user() {
  echo "$1"
}

# Sets debconf to use non-interactive mode for package installation
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update
apt-get full-upgrade -y
apt-get install -y --no-install-recommends apt-utils jq

echo "$setup_list" | jq -r 'to_entries[] | "\(.func) \(.args)"' | while read -r func args; do
  $func "$args"
done

# work_dir=$(dirname "$(realpath "$0")")
# port_list="$1"
# repo_url="$2"
# branch="$3"
# setup_role_list="$4"
# pre_setup_script="./$5"
# post_setup_script="./$6"
# php_mod_list="./$7"

# echo "$work_dir"
# echo "$port_list"
# echo "$repo_url"
# echo "$branch"
# echo "$setup_role_list"
# echo "$pre_setup_script"
# echo "$post_setup_script"
# echo "$php_mod_list"

# setup() {
#   local role="$1"

#   curl -sS -H 'Cache-Control: no-cache, no-store' "$repo_url/$role/setup.sh?ref=$branch" | \
#     jq -r '.content' | \
#     base64 -d | \
#     bash -s "$work_dir" "$port_list" "$php_mod_list"
# }

# # Sets debconf to use non-interactive mode for package installation
# echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
# apt-get update
# apt-get full-upgrade -y
# apt-get install -y --no-install-recommends apt-utils ca-certificates curl jq

# if [ -f "$pre_setup_script" ]; then $pre_setup_script; fi

# for role in $setup_role_list; do
#   setup "$role"
# done

# if [ -f "$post_setup_script" ]; then $post_setup_script; fi
