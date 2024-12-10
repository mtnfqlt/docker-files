#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

work_dir=$(dirname "$(realpath "$0")")

exec_on_exit() {
  stop_main_ps
}

start_main_ps() {
  setsid "$MAIN_PS" &
  main_pid=$!
  printf '\033[1;32mThe main process was successfully started (PID:%s).\033[0m\n' "$main_pid"
}

stop_main_ps() {
  if [ -n "$main_pid" ]; then
    kill "$main_pid"
    printf '\033[1;33mThe main process was terminated (PID:%s).\033[0m\n' "$main_pid"
  fi
}

restart_main_ps() {
  stop_main_ps
  start_main_ps
}

enable_php_mod() {
  local mod=$1

  docker-php-ext-enable "$mod"
  restart_main_ps
}

disable_php_mod() {
  local mod=$1

  rm -f "/usr/local/etc/php/conf.d/docker-php-ext-$mod.ini"
  restart_main_ps
}

trap exec_on_exit EXIT

cd "$work_dir"
echo "$(ifconfig eth0 | grep ' inet ' | awk '{print $2}'):$CTL_PORT"

setup_script='/mnt/setup.sh'
if [ -f $setup_script ]; then $setup_script; fi
cd "$work_dir"

init_list=$(find ./init.d -maxdepth 1 -type f -name '*.sh' | sort -V)

if [ -z "$MAIN_PS" ]; then
  init_list=$(echo "$init_list" | head -n -1)
  MAIN_PS=$(echo "$init_list" | tail -n -1)
fi

for init in $init_list; do
  $init
done

start_main_ps

while true; do
  eval "$(nc -lp "$CTL_PORT")" || true
done
