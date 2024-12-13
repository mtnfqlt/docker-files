#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

login_user='project'
work_dir="/home/$login_user/src"

mkdir -p $work_dir
cd $work_dir
chown $login_user:$login_user ./

if [ -n "$(find ./ -maxdepth 0 -empty)" ]; then
  if [ -n "$REPO_URL" ]; then sudo -u $login_user git clone "$REPO_URL" ./
    if [ -n "$BRANCH" ]; then sudo -u $login_user git checkout "$BRANCH"; fi
    chmod -R g+rw ./
    if [ -n "$INIT_SCRIPT" ]; then sudo -u $login_user "$INIT_SCRIPT"; fi
  fi
fi
