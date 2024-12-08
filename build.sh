#!/bin/bash -e

while [ $# -gt 0 ]; do
  case $1 in
    work_dir=*)
      work_dir="${1#*=}" ;;
    context_dir=*)
      export CONTEXT_DIR="${1#*=}" ;;
    docker_file=*)
      export DOCKER_FILE="${1#*=}" ;;
    repo_url=*)
      export REPO_URL="${1#*=}" ;;
    branch=*)
      export BRANCH="${1#*=}" ;;
  esac

  shift
done

echo "$work_dir"
echo "$CONTEXT_DIR"
echo "$DOCKER_FILE"
echo "$REPO_URL"
echo "$BRANCH"

# work_dir=$(dirname "$(realpath "$1")")
# export CONTEXT_DIR=$2
# export DOCKER_FILE=$3
# export REPO_URL=$4
# export BRANCH=$5

# cd "$work_dir"

# for file in $DOCKER_FILE setup.sh; do
#   curl -sS -H 'Cache-Control: no-cache, no-store' "$REPO_URL/$file?ref=$BRANCH" | \
#     jq -r '.content' | \
#     base64 -d > "$CONTEXT_DIR/$file"
# done

# chmod 700 "$CONTEXT_DIR/setup.sh"
# docker compose down
# docker compose --progress=plain build --no-cache --pull
# docker compose up

