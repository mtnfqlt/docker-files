#!/bin/bash -e

work_dir=$(dirname "$(realpath "$0")")

cd "$work_dir"
prj_name=$(docker compose config | yq -r '.name')
if [ -z "$prj_name" ]; then prj_name=$(basename "$$work_dir"); fi

service="$(docker compose config | \
  yq -r '.services | to_entries[] | select(.value.environment | has("DOMAIN")) | .key')"

container="$prj_name-$service-1"
gateway=$(docker exec "$container" ip route | grep '^default via ' | awk '{print $3}')

domain=$(docker compose config | \
  yq -r '.services[] | select(.environment.DOMAIN) | .environment.DOMAIN')

echo "$gateway"
echo "$domain"

# echo "$prj_name"

# network="$prj_name"_default

# echo "$network"


# docker compose config | jq -r '.networks.default.name'
# #docker network inspect $network_name | jq -r '.[0].IPAM.Config[0].Gateway'
