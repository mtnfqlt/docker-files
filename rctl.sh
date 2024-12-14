#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

# shellcheck disable=SC1091
source ./include.src

rpctl_port=54321

# shellcheck disable=SC2154
for php_ext in $enable_php_ext; do
cat << EOT | nc -q1 php-fpm $rpctl_port
start_main_init
echo enable $php_ext
EOT
done

# shellcheck disable=SC2154
for php_ext in $disable_php_ext; do
cat << EOT | nc -q1 php-fpm $rpctl_port
echo disable $php_ext
EOT
done
