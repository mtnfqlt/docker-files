#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$1"

work_dir=$(dirname "$(realpath "$1")")
cur_script=$(realpath "$1")
prj_config='./docker-compose.yml'
vm_name='dvm'

exec_on_exit() {
  if [ $? -ne 0 ]; then printf '\033[1;31m%s\033[0m\n' "$cur_script"; fi
}

exec_on_dvm(){
  local cmd=$1

  ssh -o StrictHostKeyChecking=no \
      -o UserKnownHostsFile=/dev/null \
      -o LogLevel=ERROR "ubuntu@$vm_ip" "sudo bash -c \"$cmd\"" < /dev/null
}

trap exec_on_exit EXIT

cd "$work_dir"
prj_name=$(yq -r '.name' $prj_config)
if [ -z "$prj_name" ]; then prj_name=$(basename "$$work_dir"); fi
service=$(yq -r '.services | to_entries[] | select(.value.environment | has("DOMAIN")) | .key' $prj_config)
cmd="docker exec $prj_name-$service-1 ip route | grep '^default via ' | awk '{print $$3}'"
vm_ip=$(multipass info $vm_name --format json 2> /dev/null | jq -r ".info.$vm_name.ipv4[0]")

#cmd='docker ps'
exec_on_dvm "$cmd"

# if [ -n "$vm_ip" ]; then
#   gateway=$(exec_on_dvm "$cmd")
# else
#   gateway=$(eval "$cmd")
# fi

# domain=$(yq -r '.services[] | select(.environment.DOMAIN) | .environment.DOMAIN' $prj_config)

# if [ -n "$gateway" ] && [ -n "$domain" ]; then
#   cmd="
# cd /etc
# sudo sed -i.bak '/ $domain /d' ./hosts
# sudo echo $gateway $domain \#added by $cur_script >> ./hosts
# hostname
# grep ' $domain ' ./hosts"

#   sudo bash -c "$cmd"
#   #exec_on_dvm "$cmd"
# else
#   exit 1
# fi
