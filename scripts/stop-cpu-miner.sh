#!/bin/bash -e

pgrep $CPUMINERBIN
if [ "$?" == 1 ]; then
    echo
    echo "CPU miner is not running."
    echo
    echo " Start with \"start-cpu-miner\""
    echo
else
clear

cat $MINERSCRIPTS/gpuminer.txt
sleep 0.3
cat $MINERSCRIPTS/stopping.txt
sleep 0.2

echo
sudo kill $?
    if [ "${?}" == 0 ]; then
        echo "Process ID ${cpid} has been stopped."
    else
        echo "Unable to stop Process. ${cpid}"
        sleep 1
        exit 1
    fi
fi

exit $?
