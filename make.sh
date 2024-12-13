#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

work_dir='/home/project/src'

mkdir -p $work_dir
cd $work_dir

if [ -n "$(find ./ -maxdepth 0 -empty)" ]; then
  if [ -n "$REPO_URL" ]; then
    echo "$REPO_URL"
  fi
fi
