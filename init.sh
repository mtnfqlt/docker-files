#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

work_dir=$(dirname "$(realpath "$0")")

cd "$work_dir"
ifconfig eth0 | grep ' inet ' | awk '{print $2}'

echo "$CMD"





# exec_on_exit() {
#   stop_cmd
# }

# start_cmd() {
#   if [ -n "$CMD" ]; then
#     printf '\033[1;32m%s\033[0m\n' "${FUNCNAME[0]}"
#     $CMD &
#     cmd_pid=$!
#   fi
# }

# stop_cmd() {
#   if [ -n "$cmd_pid" ]; then
#     printf '\033[1;33m%s\033[0m\n' "${FUNCNAME[0]}"
#     kill "$cmd_pid"

#     while kill -0 "$cmd_pid" 2>/dev/null; do
#       sleep 1
#     done
#   fi
# }

# restart_cmd() {
#   stop_cmd
#   start_cmd
# }

# trap exec_on_exit EXIT

# cd "$work_dir"
# ifconfig eth0 | grep ' inet ' | awk '{print $2}'

# case "$*" in
#   '') ;;
#   -*) CMD="$CMD $*" ;;
#    *) CMD=$* ;;
# esac

# init_script_list=$(find ./init.d -maxdepth 1 -type f -name '*.sh' | sort -V)

# for init_script in $init_script_list; do
#   $init_script &
# done

# start_cmd

# bind_ip='127.0.0.1'
# if [ "$EN_RCTL" = true ]; then bind_ip=''; fi

# while true; do
#   eval "$(nc -l $bind_ip -p "$RCTL_PORT")" || true
# done
