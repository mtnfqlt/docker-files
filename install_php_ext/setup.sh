#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

# shellcheck disable=SC1091
source ./include.src

# shellcheck disable=SC2154
for ext in $list; do
  name=$(echo "$ext" | cut -d- -f1)
  version=$(echo "$ext" | cut -d- -f2)
  echo "---------------------------------$version"
  if [ -z "$version" ]; then
    docker-php-ext-install "$name"
  else
    pecl install "$ext"
  fi
done
