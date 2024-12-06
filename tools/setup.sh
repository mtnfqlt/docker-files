#!/bin/bash -e

printf '\033[1;32m$0\033[0m\n'

# Sets debconf to use non-interactive mode for package installation
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

apt-get update
apt-get full-upgrade -y

apt-get install -y --no-install-recommends \
  apt-utils \
  iputils-ping \
  mc \
  net-tools \
  procps
