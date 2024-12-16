#!/bin/bash -e

work_dir=$(dirname "$(realpath "$1")")

exec_on_exit() {
  if [ $? -ne 0 ]; then printf '\033[1;31m%s\033[0m\n' "$1"; fi
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
  comment_msg="#added by $1"
  str="$gateway $domain $comment_msg"
  echo "$str"
else
  exit 1
fi

# echo "$prj_name"

# network="$prj_name"_default

# echo "$network"


# docker compose config | jq -r '.networks.default.name'
# #docker network inspect $network_name | jq -r '.[0].IPAM.Config[0].Gateway'
