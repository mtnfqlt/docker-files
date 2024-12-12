#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

work_dir=$(dirname "$(realpath "$0")")

exec_on_exit() {
  stop_cmd
}

start_cmd() {
  printf '\033[1;32m%s\033[0m\n' "${FUNCNAME[0]}"
  $CMD &
  cmd_pid=$!
}

stop_cmd() {
  printf '\033[1;33m%s\033[0m\n' "${FUNCNAME[0]}"
  if [ -n "$cmd_pid" ]; then kill "$cmd_pid"; fi
}

restart_cmd() {
  stop_cmd
  start_cmd
}

trap exec_on_exit EXIT

cd "$work_dir"
ifconfig eth0 | grep ' inet ' | awk '{print $2}'

case "$*" in
  '') ;;
  -*) CMD="$CMD $*" ;;
   *) CMD=$* ;;
esac

init_script_list=$(find ./init.d -maxdepth 1 -type f -name '*.sh' | sort -V)

# if [ -z "$CMD" ]; then
#   CMD=$(echo "$init_script_list" | tail -n -1)
#   init_script_list=$(echo "$init_script_list" | head -n -1)
# fi

for init_script in $init_script_list; do
  $init_script &
done

if [ -n "$CMD" ]; then start_cmd; fi

while true; do
  eval "$(nc -lp "$CTL_PORT")" || true
done
