#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

login_user='project'
work_dir="/home/$login_user/src"

exec_on_exit() {
  if [ $? -ne 0 ]; then printf '\033[1;31m./make.sh\033[0m\n'; fi
  ifconfig eth0 | grep ' inet ' | awk '{print $2}'
  exit 0
}

trap exec_on_exit EXIT

mkdir -p $work_dir
cd $work_dir
chown $login_user:$login_user ./

if [ -n "$(find ./ -maxdepth 0 -empty)" ]; then
  if [ -n "$REPO_URL" ]; then sudo -u $login_user git clone "$REPO_URL" ./
    if [ -n "$BRANCH" ]; then sudo -u $login_user git checkout "$BRANCH"; fi
    if [ -n "$INIT_SCRIPT" ]; then sudo -u $login_user "$INIT_SCRIPT"; fi
  fi
fi
