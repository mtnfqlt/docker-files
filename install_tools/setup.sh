#!/bin/bash -e

# shellcheck disable=SC1091
source ./include.src

# shellcheck disable=SC2154
apt-get install -y --no-install-recommends "$list" \
  dnsutils \
  iproute2 \
  iputils-ping \
  mc \
  net-tools \
  procps
