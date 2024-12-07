#!/bin/bash -e

work_dir=$(dirname "$(realpath "$1")")
repo_url=$2
branch=$3

cd "$work_dir/files"

for file in Dockerfile setup.sh; do
  curl -sS -H 'Cache-Control: no-cache, no-store' "$repo_url/$file?ref=$branch" | \
    jq -r '.content' | \
    base64 -d > ./$file
done

chmod 700 ./setup.sh

cd "$work_dir"
export REPO_URL=repo_url
export BRANCH=branch
docker compose down
docker compose --progress=plain build --no-cache --pull
docker compose up
