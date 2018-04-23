#!/bin/bash -e

source ./install.conf
source ./templates.sh

sudo apt-get install monit -y

# mkdir -p $MINERCONF
# configerd in ./install.sh with ./templates.sh
# cat ./install.conf >> ./scripts/miner.conf
# sudo cp -f ./scripts/miner.conf $MINERCONF/miner.conf

sudo rm -rf $MINERSCRIPTS
mkdir -p $MINERSCRIPTS


# backup old config
if sudo ls /etc/monit/monitrc 1> /dev/null 2>&1; then
  sudo mv -f /etc/monit/monitrc /etc/monit/monitrc.orig
  sudo chmod 600 /etc/monit/monitrc.orig
fi

sudo mv -f ./scripts/monitrc /etc/monit/monitrc
sudo chmod 600 /etc/monit/monitrc
sudo chown root:root /etc/monit/monitrc


# then move scripts
if ls ./scripts/*.sh 1> /dev/null 2>&1; then
  sudo mv -f ./scripts/*.sh $MINERSCRIPTS/.
fi
# update banner (add to default [Banner /etc/issue])
# if ls ./banners/issue.txt 1> /dev/null 2>&1; then
#   cat ./banners/issue.txt >> /etc/issue
#   rm ./banners/issue.txt # purge?
# fi
# then move scripts
if ls ./banners/*.txt 1> /dev/null 2>&1; then
  sudo cp -f ./banners/*.txt $MINERSCRIPTS/.
fi

# sudo chown -R $(logname) $MINERSCRIPTS
chmod +x $MINERSCRIPTS/*.sh


# todo : make this user based
# clear
# echo
# echo
# echo "enter credentials for your monit status (web-server)"
# echo
# echo "this will be set in: /etc/monit/monitrc"
# echo
# read -p "  USERNAME: " monituser
# echo
# read -p "  PASSWORD: " monitpasswd
# echo

# if [ ! -f /etc/monit/conf.d/monitstatusserver ]; then
  RANDOMmd5=($(md5sum $MINERCONF/miner.conf))
  addStatusServer $USER $RANDOMmd5 > tmp
  sudo mv -f tmp /etc/monit/conf.d/monitstatusserver
# fi

# Note: The number of cycles must be between 1 and 64
# param $1 is gpu test
case ${1} in
  Y|y) addStartScript gpu ${MINERSCRIPTS} 2 > tmp
  sudo mv -f tmp /etc/monit/conf.d/gpuminer ;;
esac

# param $2 is cpu test
case ${2} in
  Y|y) addStartScript cpu ${MINERSCRIPTS} 10 > tmp
  sudo mv -f tmp /etc/monit/conf.d/cpuminer ;;
esac


sudo chmod 600 /etc/monit/conf.d/*miner
sudo chown root:root /etc/monit/conf.d/*miner





# chmod 600 ./scripts/.bashminer
mv -f ./scripts/.bashminer $HOME/.bashminer
sudo chown $(logname) $HOME/.bashminer

if [ -f ./scripts/.bashmineralias ]; then
  mv -f ./scripts/.bashmineralias $MINERSCRIPTS/.bashmineralias
  sudo chown $(logname) $MINERSCRIPTS/.bashmineralias
fi


if grep -q bashminer "$HOME/.bashrc"
then
  echo ".bashminer already added to $HOME/.bashrc"
else
  echo "if [ -f $HOME/.bashminer ]; then" >> $HOME/.bashrc
  echo "    . $HOME/.bashminer" >> $HOME/.bashrc
  echo "fi" >> $HOME/.bashrc
fi



# sudo chmod 600 /etc/monit/monitrc
sudo monit -t
if test $? -eq 0
then
  sudo monit
  sleep 3
  sudo monit reload
  sleep 3
  sudo monit status
  sleep 2
else 
  echo "monit failed to configure miner watchers properly."
fi


