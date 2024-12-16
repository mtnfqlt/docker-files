#!/bin/bash

printf '\033[1;32m%s\033[0m\n' "$1"


run_on_dvm() {
  multipass exec dvm -- ls
}

route_list=$(run_on_dvm)
echo "$route_list"
