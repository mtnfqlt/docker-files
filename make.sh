#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

work_dir='/home/project/src'

mkdir -p $work_dir
cd $work_dir
chown project:project ./

if [ -n "$(find ./ -maxdepth 0 -empty)" ]; then
  if [ -n "$REPO_URL" ]; then sudo -Eu project git clone "$REPO_URL" ./
    if [ -n "$BRANCH" ]; then sudo -Eu project git checkout "$BRANCH"; fi
    if [ -n "$INIT_SCRIPT" ]; then sudo -Eu project "$INIT_SCRIPT"; fi
  fi
fi
