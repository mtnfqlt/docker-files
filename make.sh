#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

work_dir='/home/project/src'

mkdir -p $work_dir
cd $work_dir

if [ -n "$(find ./ -maxdepth 0 -empty)" ]; then
  sudo apt-get install -y --no-install-recommends git

  if [ -n "$REPO_URL" ]; then git clone "$REPO_URL" ./
    if [ -n "$BRANCH" ]; then git checkout "$BRANCH"; fi
    if [ -n "$INIT_SCRIPT" ]; then $INIT_SCRIPT; fi
  fi

  sudo apt-get clean -y
fi
