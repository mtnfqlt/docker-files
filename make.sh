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

    if [ -n "$INIT_SCRIPT" ]; then
      init_begin_time=$(date +%s)
      set +e
      sudo -u $login_user "$INIT_SCRIPT"
      exit_code=$?
      set -e

      if [ $exit_code -eq 0 ]; then
        chmod -R g+rw ./
        init_end_time=$(date +%s)
        init_time_diff=$(("$init_end_time" - "$init_begin_time"))
        init_time="$(("$init_time_diff" / 60)) minutes $(("$init_time_diff" % 60)) seconds"
        printf '\033[1;32mInitialization successfully completed, lasted %s.\033[0m\n' "$init_time"
      else
        printf '\033[1;31mInitialization error!\033[0m\n'
      fi
    fi
  fi
fi
