#!/bin/bash -e

work_dir=$(dirname "$(realpath "$0")")

cd "$work_dir"
# shellcheck disable=SC1091
source ./include.src

rctl_port=54321

send() {
  local cmd=$1
  local service=$2

  echo -e "$cmd" | nc -q1 "$service" $rctl_port
}

print_php_ext_status() {
  local ext=$1
  local cmd="if php -i | grep -q ^$ext.; then status=enabled; else status=disabled; fi; echo $ext \$status"

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
      sudo "$cmd"
    ;;
    disable)
      cmd="rm -f $ini"
      sudo "$cmd"
    ;;
  esac

  send "$cmd\nrestart_main_init" php-fpm
  print_php_ext_status "$ext"
}

# shellcheck disable=SC2154
for ext in $enable_php_ext; do
  eval toggle_php_ext "$ext" enable
done

# shellcheck disable=SC2154
for ext in $disable_php_ext; do
  eval toggle_php_ext "$ext" disable
done
