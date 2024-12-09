#!/bin/bash -e

# shellcheck disable=SC1091
source ./include.src

# shellcheck disable=SC2154
docker-php-ext-enable "$list"
