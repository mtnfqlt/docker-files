#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

ctl_port=$1
main_ps=$2

exec_on_exit() {
  stop_main_ps
}

start_main_ps() {
  setsid "$main_ps" &
  main_pid=$!
  printf '\033[1;32mThe main process was successfully started (PID:%s).\033[0m\n' $main_pid
}

stop_main_ps() {
  if [ -n "$main_pid" ]; then
    kill "$main_pid"
    printf '\033[1;33mThe main process was terminated (PID:%s).\033[0m\n' $main_pid
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

ip=$(ifconfig eth0 | grep ' inet ' | awk '{print $2}')
echo "$ip:$ctl_port"
start_main_ps

while true; do
  eval "$(nc -lp "$ctl_port")" || true
done
