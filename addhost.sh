#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$1"

work_dir=$(dirname "$(realpath "$1")")
cur_script=$(realpath "$1")
prj_config='./docker-compose.yml'

exec_on_exit() {
  if [ $? -ne 0 ]; then printf '\033[1;31m%s\033[0m\n' "$cur_script"; fi
}

run_on_dvm() {
  local cmd="$1"
  local vm_name='dvm'

  if multipass info $vm_name 2> /dev/null | grep -q '^State:\s*Running$'; then
    multipass exec $vm_name -- bash -e << EOT
$cmd
EOT
  fi
}

trap exec_on_exit EXIT

cd "$work_dir"
prj_name=$(yq -r '.name' $prj_config)
if [ -z "$prj_name" ]; then prj_name=$(basename "$$work_dir"); fi
service=$(yq -r '.services | to_entries[] | select(.value.environment | has("DOMAIN")) | .key' $prj_config)
cmd="docker exec $prj_name-$service-1 ip route"
route_list=$(run_on_dvm "$cmd" 2> /dev/null)
if [ -z "$route_list" ]; then route_list=$(eval "$cmd"); fi
gateway=$(echo "$route_list" | grep '^default via ' | awk '{print $3}')
domain=$(yq -r '.services[] | select(.environment.DOMAIN) | .environment.DOMAIN' $prj_config)

echo "$gateway"
echo "$domain"

if [ -n "$gateway" ] && [ -n "$domain" ]; then
  cmd="
cd /etc
sed -i '/ $domain /d' ./hosts
echo $gateway $domain \#added by $cur_script >> ./hosts
hostname
getent hosts $domain"

  sudo bash -ec "$cmd"
  # vm_name='dvm'

  # if multipass info $vm_name 2> /dev/null | grep -q '^State:\s*Running$'; then
  #   echo
  #   multipass exec $vm_name -- sudo bash -ec "$cmd"
  # fi
else
  exit 1
fi
