#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

# shellcheck disable=SC1091
source ./include.src

# shellcheck disable=SC2154
echo "$list"
echo "$@"

while [ $# -gt 0 ]; do
    echo "Arg: $1"
    shift
done
echo "Po ciklo: $@"

pecl install redis-6.1.0
sleep 30
# for mod in $list; do
#   eval pecl install "$mod"
# done
