#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

# shellcheck disable=SC1091
source ./include.src

composer_file='/usr/local/bin/composer'

# shellcheck disable=SC2154
curl -sSLo $composer_file "https://getcomposer.org/download/$version/composer.phar"
chmod a+x $composer_file
