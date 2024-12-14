#!/bin/bash -e

work_dir=$(dirname "$(realpath "$0")")

cd "$work_dir"
# shellcheck disable=SC1091
source ./include.src

rctl_port=54321

send() {
  local cmd_list=$1
  local service=$2

  echo "$cmd_list" | nc -q1 "$service" $rctl_port
}

# shellcheck disable=SC2154
for php_ext in $enable_php_ext; do
  case $php_ext in
    xdebug)
      cmd_list='
echo enable xdebug
echo enable xdebug'
      send "$cmd_list" php-fpm
    ;;
    *) ;;
  esac
done

# shellcheck disable=SC2154
for php_ext in $disable_php_ext; do
  case $php_ext in
    xdebug)
      cmd_list='
echo disable xdebug
echo disable xdebug'
      send "$cmd_list" php-fpm
    ;;
    *) ;;
  esac
done
