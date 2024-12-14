#!/bin/bash -e

work_dir=$(dirname "$(realpath "$0")")

cd "$work_dir"
# shellcheck disable=SC1091
source ./include.src

rctl_port=54321

send() {
  local cmd_list=$1
  local service=$2

  echo -e "$cmd_list" | nc -q1 "$service" $rctl_port
}

xdebug() {
  local state=$1
  local cmd

  case $state in
    enable)
      cmd="docker-php-ext-enable $php_ext"
      $cmd
    ;;
    disable)
      cmd="rm -f /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini"
      $cmd
    ;;
  esac

  send "$cmd\nrestart_main_init" php-fpm
}

# shellcheck disable=SC2154
for php_ext in $enable_php_ext; do
  eval "$php_ext" enable
done

# shellcheck disable=SC2154
for php_ext in $disable_php_ext; do
  eval "$php_ext" disable
done
