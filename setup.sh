#!/bin/bash -e

work_dir=$(dirname "$(realpath "$0")")
ports="$1"
repo_url="$2"
branch="$3"
setup_role_list="$4"
pre_setup_script="./$5"
post_setup_script="./$6"

echo "$work_dir"
echo "$ports"
echo "$repo_url"
echo "$branch"
echo "$setup_role_list"
echo "$pre_setup_script"
echo "$post_setup_script"

setup() {
  local role="$1"

  curl -sS -H 'Cache-Control: no-cache, no-store' "$repo_url/$role/setup.sh?ref=$branch" | \
    jq -r '.content' | \
    base64 -d | \
    bash -s "$work_dir" "$ports"
}

# Sets debconf to use non-interactive mode for package installation
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update
apt-get full-upgrade -y
apt-get install -y --no-install-recommends ca-certificates curl jq

if [ -f "$pre_setup_script" ]; then $pre_setup_script; fi

for role in $setup_role_list; do
  setup "$role"
done

if [ -f "$post_setup_script" ]; then $post_setup_script; fi
