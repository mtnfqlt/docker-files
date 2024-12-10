#!/bin/bash -e

printf '\033[1;32m%s\033[0m\n' "$0"

init_script='./init.sh'

# shellcheck disable=SC1091
source ./include.src

# shellcheck disable=SC2154
cat > $init_script << EOT
#!/bin/bash -e

main_ps='$main_ps'

ifconfig eth0 | grep ' inet ' | awk '{print \$2}'
exec $main_ps &

while true; do
  pgrep -f $main_ps
  sleep 1000
done
EOT

chmod 700 $init_script


cat ./init.sh
