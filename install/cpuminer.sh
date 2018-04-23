#!/bin/bash -e

which cpuminer
if test $? -eq 1
then
  sudo apt-get update
  sudo apt-get install libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential libgmp3-dev -y

  git clone https://github.com/JayDDee/cpuminer-opt.git
  cd cpuminer-opt
  ./build.sh

  sudo cp -f cpuminer /usr/bin/cpuminer
fi
echo
echo "cpuminer running from: $(which cpuminer)"
echo