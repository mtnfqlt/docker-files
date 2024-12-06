#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"
sleep 3

apt-get install -y --no-install-recommends ssh
