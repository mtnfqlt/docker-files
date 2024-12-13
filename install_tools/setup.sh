#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

# shellcheck disable=SC1091
source ./include.src

# shellcheck disable=SC2154
eval apt-get install -y --no-install-recommends "$list" \
  curl \
  dnsutils \
  iproute2 \
  iputils-ping \
  mc \
  p7zip-full \
  procps \
  wget
