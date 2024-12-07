#!/bin/bash -e

work_dir=$(dirname "$(realpath "$1")")
file_dir=$work_dir/files
repo_url='https://raw.githubusercontent.com/mtnfqlt/docker-files/refs/heads/main'

cd "$work_dir"
mkdir -p "$file_dir"
wget -nv $repo_url/Dockerfile $repo_url/setup.sh -P "$file_dir"

# docker compose down
# docker compose --progress=plain build --no-cache --pull
# docker compose up
