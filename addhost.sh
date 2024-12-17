#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$1"

work_dir=$(dirname "$(realpath "$1")")
cur_script=$(realpath "$1")
prj_config='./docker-compose.yml'
vm_name='dvm'

exec_on_exit() {
  if [ $? -ne 0 ]; then printf '\033[1;31m%s\033[0m\n' "$cur_script"; fi
}

# exec_on_dvm(){
#   local vm_name='dvm'

#   if multipass info $vm_name 2> /dev/null | grep -q '^State:\s*Running$'; then
#     vm_ip
#     #gateway=$(echo "$cmd" | multipass shell | grep '^default via ' | awk '{print $3}')
#   fi
# }

trap exec_on_exit EXIT

cd "$work_dir"
prj_name=$(yq -r '.name' $prj_config)
if [ -z "$prj_name" ]; then prj_name=$(basename "$$work_dir"); fi
service=$(yq -r '.services | to_entries[] | select(.value.environment | has("DOMAIN")) | .key' $prj_config)
cmd="docker exec $prj_name-$service-1 ip route"

vm_ip=$(multipass info $vm_name --format json | jq -r ".info.$vm_name.ipv4[0]")
echo "$vm_ip"

# if multipass info $vm_name 2> /dev/null | grep -q '^State:\s*Running$'; then
#   gateway=$(echo "$cmd" | multipass shell | grep '^default via ' | awk '{print $3}')
# fi

# if [ -z "$gateway" ]; then gateway=$(eval "$cmd" | grep '^default via ' | awk '{print $3}'); fi
# domain=$(yq -r '.services[] | select(.environment.DOMAIN) | .environment.DOMAIN' $prj_config)

# if [ -n "$gateway" ] && [ -n "$domain" ]; then
#   cmd="
# set -e
# cd /etc
# sed -i.bak '/ $domain /d' ./hosts
# echo $gateway $domain \#added by $cur_script >> ./hosts
# hostname
# grep ' $domain ' ./hosts"

#   sudo bash -ec "$cmd"

#   if multipass info $vm_name 2> /dev/null | grep -q '^State:\s*Running$'; then
#     echo
#     echo "sudo bash -ec \"$cmd\"" | multipass shell
#   fi
# else
#   exit 1
# fi
