#!/bin/bash -e

work_dir=$(dirname "$(realpath "$1")")
export REPO_URL=$2
export BRANCH=$3
export CONTEXT='./files'
export DOCKERFILE='Dockerfile'

cd "$work_dir"

for file in $DOCKERFILE setup.sh; do
  curl -sS -H 'Cache-Control: no-cache, no-store' "$REPO_URL/$file?ref=$BRANCH" | \
    jq -r '.content' | \
    base64 -d > $CONTEXT/$file
done

chmod 700 $CONTEXT/setup.sh
docker compose down
docker compose --progress=plain build --no-cache --pull
docker compose up
