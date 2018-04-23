#!/bin/bash


# ${1} name
# ${2} log file name (relative)
# ${3} log directory MINERLOGDIR
# ${4} restart log file MINERSTARTLOGFILE
rotateMiningLog () {
    __NOW__=$(date '+%d-%m-%Y-%H:%M:%S')

    #rotate log
    mkdir -p ${3}

	if [ -f ${2} ]; then
	    mv -f ${2} "${3}/${__NOW__}-${1}-miner.log"
	fi

    #log restart
    echo " ${1} :: ${__NOW__}" >> ${4}
}