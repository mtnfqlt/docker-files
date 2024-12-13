#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

# shellcheck disable=SC1091
source ./include.src

login_user='project'
useradd $login_user --comment 'Project' --create-home --shell /bin/bash
usermod -aG www-data $login_user
usermod -aG $login_user www-data
