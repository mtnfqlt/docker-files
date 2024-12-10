#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

init_script='./init.sh'

# shellcheck disable=SC1091
source ./include.src

# shellcheck disable=SC2154
cat > $init_script << EOT
#!/bin/bash -e

ctl_port=$ctl_port
main_ps='$main_ps'

exec_on_exit() {
  stop_main_ps
}

start_main_ps() {
  setsid \$main_ps &
  main_pid=\$!
  printf '\033[1;32mThe main process was successfully started (PID:%s).\033[0m\n' \$main_pid
}

stop_main_ps() {
  if [ -n "\$main_pid" ]; then
    kill "\$main_pid"
    printf '\033[1;31mThe main process was terminated (PID:%s).\033[0m\n' \$main_pid
  fi
}

restart_main_ps() {
  stop_main_ps
  start_main_ps
}

trap exec_on_exit EXIT

ip=\$(ifconfig eth0 | grep ' inet ' | awk '{print \$2}')
echo "\$ip:\$ctl_port"
start_main_ps

while true; do
  eval "\$(nc -lp \$ctl_port)" || true
done
EOT

chmod 700 $init_script
