#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$1"

work_dir='/home/project/src'

mkdir -p $work_dir
cd $work_dir

if [ -z "$(ls -a ./)" ]; then
  if [ -n "$REPO_URL" ]; then
    echo aaaaa
  fi
fi
