#!/bin/bash -e

source /usr/local/etc/miner.conf

pgrep $GPUMINERBIN
if [ "$?" == 1 ]; then

    source $MINERSCRIPTS/rotate-log.sh
    rotateMiningLog gpu \
        ${GPUMINERLOGFILE} \
        ${MINERLOGDIR} \
        ${MINERSTARTLOGFILE}

    $GPUMINERBIN \
        -o $POOLURL:$GPUPOOLPORT \
        -u "$MINERUSERNAME.$MINERWORKERNAME-gpu" \
        -p $MINERPASSWORD \
        -a $ALGO > $GPUMINERLOGFILE &
        # -i ${INTENSITY} \
        #   --submit-stale \

    cat $MINERSCRIPTS/gpuminer.txt
    cat $MINERSCRIPTS/starting.txt
    echo "${GPUMINERBIN} @ ${POOLURL}:${GPUPOOLPORT}"

    echo
    echo
    
    pgrep $GPUMINERBIN
    exit $?

else
    echo
    echo "Cannot start miner."
    echo "${GPUMINERBIN} already running: $pid"
    echo
fi

exit 1
