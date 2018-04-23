#!/bin/bash -e

#ssh only ports
sudo apt-get install ufw -y
sleep 1

# for OpenSSH
sudo ufw allow ssh/tcp
sleep 2
sudo ufw limit ssh/tcp
sleep 2

# for monit status
sudo ufw allow 2812/tcp
sleep 2
sudo ufw reload
sleep 2

sudo ufw logging on
sleep 2

sudo ufw enable
sleep 3


sudo ufw status
sleep 1

# exit