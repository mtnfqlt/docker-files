#!/bin/bash -e

prj_name=$(docker compose config | yq '.name')

if [ -z "$prj_name" ]; then prj_name=$(basename "$(dirname "$(realpath "$0")")"); fi

echo "$prj_name"
