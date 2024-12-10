#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

init_script='./init.sh'

# shellcheck disable=SC1091
source ./include.src

# shellcheck disable=SC2154
cat > $init_script << EOT
ctl_port=$ctl_port
main_ps='$main_ps'

exec_on_exit() {
  stop
}

start() {
  setsid \$main_ps &
  main_pid=\$!
  printf '\033[1;32mThe main process was successfully started (PID:%s).\033[0m\n' \$main_pid
}

stop() {
  if [ -n "\$main_pid" ]; then
    kill "\$main_pid"
    printf '\033[1;31mThe main process was successfully terminated (PID:%s).\033[0m\n' \$main_pid
  fi
}

restart() {
  stop
  start
}

trap exec_on_exit EXIT

start

while true; do
  eval "\$(nc -lp \$ctl_port)" || true
done
EOT

chmod 700 $init_script

cat $init_script
