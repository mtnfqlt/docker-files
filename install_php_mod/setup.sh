#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

# shellcheck disable=SC1091
source ./include.src

# shellcheck disable=SC2154
echo "$list"
pecl install redis-6.1.0
# for mod in $list; do
#   eval pecl install "$mod"
# done
