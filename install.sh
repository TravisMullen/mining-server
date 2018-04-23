#!/bin/bash -e

source ./install.conf
source ./templates.sh

if [ -f ./scripts/update-miner.sh ]; then
    source ./scripts/update-miner.sh
else 
  echo "Update your local repository before continuing."
  echo
  echo "Try..."
  echo "\"git stash\" and \"git pull origin master\""
  echo
  exit 1
fi

# Ubuntu Server 16.04.4 LTS
# The long-term support version of Ubuntu Server, including the Mitaka release of OpenStack and support guaranteed until April 2021 — 64-bit only.
# https://www.ubuntu.com/download/server/thank-you?version=16.04.4&architecture=amd64

clear 
cat ./banners/header.txt
sleep 2

clear 
echo
cat ./banners/starting.txt
sleep 1

# read -p "  what is the name of this worker? (example: \"MyAwesomeMiningRig\") " minerworkername
clear
echo
cat ./banners/install.txt
sleep 0.5
cat ./banners/cpuminer.txt
echo
read -p "  install cpuminer-opt for your CPU? (y/n) " cpusupport

clear
echo
cat ./banners/install.txt
sleep 0.5
cat ./banners/gpuminer.txt
echo
read -p "  install ccminer for your nvidia GPU(s)? (y/n) " gpusupport


clear
echo
cat ./banners/install.txt
sleep 0.5
echo
read -p "  install monitoring and auto restarting of your miner/system? (y/n) " autostartsupport
case "$autostartsupport" in
  y|Y ) updateMinerConfUI ./install.conf ${MINERCONF}
    clear
    echo
    cat ./banners/install.txt
    sleep 0.5
    echo
    read -p "  install ufw with ssh and port 2812 for monit status? (y/n) " ufwsupport
    ;;
esac

clear
echo
cat ./banners/install.txt
sleep 0.5
echo
read -p "  automatically reboot after install? (y/n) " autorestartinstall

clear
echo
cat ./banners/install.txt
sleep 0.5
echo
echo "  assigning worker name \"${HOSTNAME}\"."
sleep 3
echo
echo "  updating & upgrading system packages"
sleep 2


sudo apt-get update && sudo apt-get upgrade -y


case "$gpusupport" in 
  y|Y ) source ./install/ccminer.sh ;;
  * ) echo "not installing ccminer." ;;
esac

case "$cpusupport" in 
  y|Y ) source ./install/cpuminer.sh ;;
  * ) echo "not installing cpuminer." ;;
esac

case "$autostartsupport" in 
  # param $1 is gpu test
  # param $2 is cpu test
  y|Y ) source ./install/autorestart.sh $gpusupport $cpusupport ;;
  * ) echo "not installing monitoring and auto restarting." ;;
esac

case "$ufwsupport" in 
  y|Y ) source ./install/ufw.sh ;;
  * ) echo "skipping ufw set-up." ;;
esac


completedInstall

cat ./banners/reboot.txt

case "$autorestartinstall" in 
  y|Y ) sleep 1
  sudo reboot ;;
esac

exit 0
