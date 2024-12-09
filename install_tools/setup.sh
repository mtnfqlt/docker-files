#!/bin/bash -e

# shellcheck disable=SC1091
source ./include.src

default_list='
  dnsutils
  iproute2
  iputils-ping
  mc
  net-tools
  procps'

# shellcheck disable=SC2154
list="$default_list $list"
apt-get install -y --no-install-recommends "$list"
