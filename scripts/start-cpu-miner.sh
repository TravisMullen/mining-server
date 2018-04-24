#!/bin/bash -e

source /usr/local/etc/miner.conf

pgrep $CPUMINERBIN
if [ "$?" == 1 ]; then

    source $MINERSCRIPTS/rotate-log.sh
    rotateMiningLog cpu \
        ${CPUMINERLOGFILE} \
        ${MINERLOGDIR} \
        ${MINERSTARTLOGFILE}

    $CPUMINERBIN \
        -o $POOLURL:$CPUPOOLPORT \
        -u "$MINERUSERNAME.$HOSTNAME-cpu" \
        -p $MINERPASSWORD \
        -a $ALGO > $CPUMINERLOGFILE &

    clear
    cat $MINERSCRIPTS/cpuminer.txt
    cat $MINERSCRIPTS/starting.txt
    echo "${CPUMINERBIN} @ ${POOLURL}:${CPUPOOLPORT}"

    echo
    echo

    pgrep $CPUMINERBIN
    exit $?

else
    echo
    echo "Cannot start miner."
    echo "${CPUMINERBIN} already running: $pid"
    echo
fi

exit $pid
