#!/bin/bash -e

work_dir=$(dirname "$(realpath "$1")")

echo "$work_dir"
# docker compose down
# docker compose --progress=plain build --no-cache --pull
# docker compose up
