#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

work_dir=$(dirname "$(realpath "$0")")

exec_on_exit() {
  stop_main_init
}

start_main_init() {
  if [ -n "$MAIN_INIT" ]; then
    printf '\033[1;32m%s\033[0m\n' "${FUNCNAME[0]}"
    $MAIN_INIT &
    main_init_pid=$!
  fi
}

stop_main_init() {
  if [ -n "$main_init_pid" ]; then
    printf '\033[1;33m%s\033[0m\n' "${FUNCNAME[0]}"
    kill "$main_init_pid"

    while kill -0 "$main_init_pid" 2>/dev/null; do
      sleep 1
    done
  fi
}

restart_main_init() {
  stop_main_init
  start_main_init
}

trap exec_on_exit EXIT

cd "$work_dir"
ifconfig eth0 | grep ' inet ' | awk '{print $2}'

init_script_list=$(find ./init.d -maxdepth 1 -type f -name '*.sh' | sort -V)

for init_script in $init_script_list; do
  $init_script &
done

if [ -n "$*" ]; then MAIN_INIT="$*"; fi
start_main_init

umask 002
if [ -n "$REPO_URL" ]; then ./make.sh; fi

bind_ip='127.0.0.1'
if [ "$ENABLE_RCTL" = true ]; then bind_ip=''; fi

while true; do
  eval "$(nc -l $bind_ip -p 54321)" || true
done
