#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

init_script='./init.sh'

# shellcheck disable=SC1091
source ./include.src

# shellcheck disable=SC2154
cat > $init_script << EOT
#!/bin/bash -e

exec $main_ps
EOT

chmod 700 $init_script
