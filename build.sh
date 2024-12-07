#!/bin/bash -e

work_dir=$(dirname "$(realpath "$1")")
file_dir=$work_dir/files
repo_url='https://raw.githubusercontent.com/mtnfqlt/docker-files/refs/heads/main'
setup_script_name='setup.sh'

cd "$work_dir"
mkdir -p "$file_dir"
wget -nv --no-continue $repo_url/Dockerfile $repo_url/$setup_script_name -P "$file_dir"
chmod 700 "$file_dir/$setup_script_name"

# docker compose down
# docker compose --progress=plain build --no-cache --pull
# docker compose up
