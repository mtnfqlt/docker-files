#!/bin/bash -e

# shellcheck disable=SC1091
source ./include.src

# shellcheck disable=SC2154
for mod in $list; do
  pecl install "$mod"
done
