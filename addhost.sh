#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$1"

work_dir=$(dirname "$(realpath "$1")")
script=$(realpath "$1")

exec_on_exit() {
  if [ $? -ne 0 ]; then printf '\033[1;31m%s\033[0m\n' "$script"; fi
}

trap exec_on_exit EXIT

cd "$work_dir"
prj_name=$(docker compose config | yq -r '.name')
if [ -z "$prj_name" ]; then prj_name=$(basename "$$work_dir"); fi

service="$(docker compose config | \
  yq -r '.services | to_entries[] | select(.value.environment | has("DOMAIN")) | .key')"

container="$prj_name-$service-1"
gateway=$(docker exec "$container" ip route | grep '^default via ' | awk '{print $3}')

domain=$(docker compose config | \
  yq -r '.services[] | select(.environment.DOMAIN) | .environment.DOMAIN')

if [ -n "$gateway" ] && [ -n "$domain" ]; then
  cmd="
cd /etc
sed -i '/ $domain /d' ./hosts
echo $gateway $domain \#added by $script >> ./hosts
hostname
getent hosts $domain"

  sudo bash -ec "$cmd"
  vm_name='dvm'

  if multipas info $vm_name | grep -q '^State:\s*Running$' 2> /dev/null; then
    echo
    multipass exec $vm_name -- sudo bash -ec "$cmd"
  fi
  echo aaaa
else
  exit 1
fi
