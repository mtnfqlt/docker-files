#!/bin/bash -e

prj_name=$(docker compose config | yq -r '.name')

if [ -z "$prj_name" ]; then prj_name=$(basename "$(dirname "$(realpath "$0")")"); fi

echo "$prj_name"

network="$prj_name"_default

echo "$network"
