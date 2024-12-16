#!/bin/bash -e

work_dir=$(dirname "$(realpath "$0")")

cd "$work_dir"
prj_name=$(docker compose config | yq -r '.name')
if [ -z "$prj_name" ]; then prj_name=$(basename "$$work_dir"); fi

service="$(docker compose config | \
  yq -r '.services | to_entries[] | select(.value.environment | has("DOMAIN")) | .key')"

container="$prj_name"_"$service"-1
docker exec -it "$container" ip route

# echo "$prj_name"

# network="$prj_name"_default

# echo "$network"


# docker compose config | jq -r '.networks.default.name'
# #docker network inspect $network_name | jq -r '.[0].IPAM.Config[0].Gateway'
