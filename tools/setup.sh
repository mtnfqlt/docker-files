#!/bin/bash -e

apt-get update
apt-get full-upgrade -y

apt-get install -y --no-install-recommends \
  apt-utils \
  iputils-ping \
  mc \
  net-tools \
  procps
