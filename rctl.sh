#!/bin/bash -e

work_dir=$(dirname "$(realpath "$0")")

cd "$work_dir"
# shellcheck disable=SC1091
source ./include.src

rctl_port=54321

exec_on_exit() {
  if [ $? -ne 0 ]; then printf '\033[1;31m%s\033[0m\n' "$0"; fi
}

send() {
  local cmd=$1
  local service=$2
  local count=1

  while ! echo -e "$cmd" | nc -q1 "$service" $rctl_port 2> /dev/null; do
    if [ $count -eq 10 ]; then exit 1; fi
    sleep 0.5
    count=$((++ count))
  done
}

print_php_ext_status() {
  local ext=$1
  local cmd="
if php -i | grep -q ^$ext.; then
  status='enabled'
else
  status='disabled'
fi

printf '\033[1;32m$ext %s\033[0m\n' \"\$status\""

  eval "$cmd"
  send "$cmd" php-fpm
}

toggle_php_ext() {
  local ext=$1
  local state=$2
  local cmd
  local ini="/usr/local/etc/php/conf.d/docker-php-ext-$ext.ini"

  case $state in
    enable)
      cmd="docker-php-ext-enable --ini-name=$ini $ext"
      eval sudo "$cmd"
    ;;
    disable)
      cmd="rm -f $ini"
      eval sudo "$cmd"
    ;;
    *) ;;
  esac

  send "$cmd\nrestart_main_init" php-fpm
  print_php_ext_status "$ext"
}

trap exec_on_exit EXIT

# shellcheck disable=SC2154
for ext in $enable_php_ext; do
  eval toggle_php_ext "$ext" enable
done

# shellcheck disable=SC2154
for ext in $disable_php_ext; do
  eval toggle_php_ext "$ext" disable
done
