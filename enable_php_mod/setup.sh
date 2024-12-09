#!/bin/bash -e

printf '\033[1;32ms%\033[0m\n' "$0"

# shellcheck disable=SC1091
source ./include.src

# shellcheck disable=SC2154
docker-php-ext-enable "$list"
