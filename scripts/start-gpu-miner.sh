#!/bin/bash -e

source /usr/local/etc/miner.conf

pid=$(pgrep ${GPUMINERBIN})
if [ "${pid}" == 1 ]; then

    echo "starting 1"
    source $MINERSCRIPTS/rotate-log.sh
    rotateMiningLog gpu \
        ${GPUMINERLOGFILE} \
        ${MINERLOGDIR} \
        ${MINERSTARTLOGFILE}

    echo "starting 2"
    ${GPUMINERBIN} \
        -o ${POOLURL}:${GPUPOOLPORT} \
        -u "${MINERUSERNAME}.${MINERWORKERNAME}-gpu" \
        -p ${MINERPASSWORD} \
        -a ${ALGO} > ${GPUMINERLOGFILE} &
        # -i ${INTENSITY} \
        #   --submit-stale \

    echo "starting 3"
    cat $MINERSCRIPTS/gpuminer.txt
    cat $MINERSCRIPTS/starting.txt
    echo "${GPUMINERBIN} @ ${POOLURL}:${GPUPOOLPORT}"

    echo
    echo

    echo "starting 4"
    pgrep ${GPUMINERBIN}
    exit $?

else
    echo
    echo "Cannot start miner."
    echo "${GPUMINERBIN} already running: $pid"
    echo
fi

exit $pid
