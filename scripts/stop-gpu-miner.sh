#!/bin/bash -e

pgrep $GPUMINERBIN
if [ "$?" == 1 ]; then
    echo
    echo "Graphics (GPU) miner is not running."
    echo
    echo " Start with \"start-gpu-miner\""
    echo
else
clear

cat $MINERSCRIPTS/cpuminer.txt
sleep 0.3
cat $MINERSCRIPTS/stopping.txt
sleep 0.2

echo
sudo kill $?
    if [ "${?}" == 0 ]; then
        echo "Process ID ${gpid} has been stopped."
    else
        echo "Unable to stop Process. ${gpid}"
        sleep 1
        exit 1
    fi
fi

exit $?