#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$1"

work_dir=$(dirname "$(realpath "$1")")
cur_script=$(realpath "$1")
prj_config='./docker-compose.yml'
vm_name='dvm'

exec_on_exit() {
  if [ $? -ne 0 ]; then printf '\033[1;31mExiting due to an error...\033[0m\n'; fi
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
cmd="docker exec $prj_name-$service-1 ip route"
vm_ip=$(multipass info $vm_name --format json 2> /dev/null | jq -r ".info.$vm_name.ipv4[0]")

if [[ "$vm_ip" =~ ^[1-9] ]]; then
  route_list=$(exec_on_dvm "$cmd")
else
  printf '\033[1;33mThe virtual machine (%s) is not running on your computer.\033[0m\n' "$vm_name"
fi

if [ -z "$route_list" ]; then
  if docker > /dev/null 2>&1; then
    route_list=$(eval "$cmd")
  else
    printf '\033[1;31mDocker was not found on your computer!\033[0m\n'
    exit 1
  fi
fi

gateway=$(echo "$route_list" | grep '^default via ' | awk '{print $3}')
domain=$(yq -r '.services[] | select(.environment.DOMAIN) | .environment.DOMAIN' $prj_config)

if [[ "$gateway" =~ ^[1-9] ]] && [ -n "$domain" ]; then
  cmd="
cd /etc
sudo sed -i.bak '/ $domain /d' ./hosts
sudo echo $gateway $domain \# Added by $cur_script at $(date +%F' '%T) >> ./hosts
grep ' $domain ' ./hosts"

  if [[ "$vm_ip" =~ ^[1-9] ]]; then
    printf '\033[1;34mScript result on %s:\033[0m\n' "$vm_name"
    exec_on_dvm "$cmd"
  fi

  printf '\033[1;32mScript result on %s:\033[0m\n' "$(hostname)"
  if ! sudo bash -c "$cmd" | grep -E "^$gateway $domain #"; then exit 1; fi
else
  exit 1
fi
