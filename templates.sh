#!/bin/bash -e

# ${1} miner name
# ${2} path to scripts
# ${3} cycles to fail before start
addStartScript () {
  echo "check program ${1}-miner with path \"/bin/bash -c '. ${2}/check-${1}-miner.sh'\""
  echo "  if status == 1 for ${3} cycles then exec \"/bin/bash -c '. ${2}/start-${1}-miner.sh'\""
  # echo "    as uid $(logname) and gid $(logname)"
  echo "  group miners"
  echo ""
}

# ${1} login username
# ${2} login password
addStatusServer () {
  echo "set httpd port 2812 and"
  echo "  use address 0.0.0.0"  # only accept connection from localhost
  echo "#  allow localhost"       # allow localhost to connect to the server and
  echo "  allow ${1}:${2}"      # require user 'admin' with password 'monit'
}

completedInstall () {
    clear 
    echo
    cat ./banners/install.txt
    cat ./banners/complete.txt
    sleep 2
}
