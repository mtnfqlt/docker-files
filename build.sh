#!/bin/bash -e

for arg in "$@"; do
  case $arg in
    work_dir=*)
      #work_dir="${arg#*=}" ;;
      eval "$arg" ;;
    context_dir=*)
      export CONTEXT_DIR="${arg#*=}" ;;
    docker_file=*)
      export DOCKER_FILE="${arg#*=}" ;;
    repo_url=*)
      export REPO_URL="${arg#*=}" ;;
    branch=*)
      export BRANCH="${arg#*=}" ;;
  esac
done

echo "$work_dir"
echo "$CONTEXT_DIR"
echo "$DOCKER_FILE"
echo "$REPO_URL"
echo "$BRANCH"

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

