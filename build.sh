#!/bin/bash -e

# work_dir=$(dirname "$(realpath "$1")")
# file_dir=$work_dir/files
# repo_url='https://raw.githubusercontent.com/mtnfqlt/docker-files/refs/heads/main'
# setup_script_name='setup.sh'

# mkdir -p "$file_dir"
# cd "$file_dir"

# curl -sS -H 'Cache-Control: no-cache' \
#   -o ./Dockerfile $repo_url/Dockerfile \
#   -o ./$setup_script_name $repo_url/$setup_script_name

# chmod 700 ./$setup_script_name

# cd "$work_dir"
# docker compose down
# docker compose --progress=plain build --no-cache --pull
# docker compose up
