#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

work_dir='/home/project/src'

mkdir -p $work_dir
sudo chown project:project $work_dir
cd $work_dir

if [ -n "$(find ./ -maxdepth 0 -empty)" ]; then
  sudo apt-get install -y --no-install-recommends git
  # shellcheck disable=SC2153
  repo_url=$(sudo echo "$REPO_URL")

  if [ -n "$repo_url" ]; then git clone "$repo_url" ./
    # shellcheck disable=SC2153
    branch=$(sudo echo "$BRANCH")
    if [ -n "$branch" ]; then git checkout "$branch"; fi
    # shellcheck disable=SC2153
    init_script=$(sudo echo "$INIT_SCRIPT")
    if [ -n "$init_script" ]; then $init_script; fi
  fi

  sudo apt-get clean -y
fi
