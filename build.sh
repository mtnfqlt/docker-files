#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$1"

work_dir=$(dirname "$(realpath "$1")")

cd "$work_dir"

docker compose down
docker compose --progress=plain build --no-cache --pull
#docker compose up
