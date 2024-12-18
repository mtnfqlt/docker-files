#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

# shellcheck disable=SC1091
source ./include.src

if [ -n "$list" ]; then eval docker-php-ext-install "$list"; fi
