#!/bin/bash

source /usr/local/etc/miner.conf

pgrep ${GPUMINERBIN}

exit $?
