#!/bin/bash -e

LOCALSTORAGE="storage.conf"

# update jawn.

# ${1} login username
# ${2} login password
# ${3} pool
# ${4} cpuport
# ${5} gpuport
# ${6} algo
# ${7} filename (.conf)
updateMinerConf () {

    grep -v MINERUSERNAME ${7} > tempedit && mv tempedit ${7}
    echo "MINERUSERNAME=${1}" >> "${7}"

    grep -v MINERPASSWORD ${7} > tempedit && mv tempedit ${7}
    echo "MINERPASSWORD=${2}" >> "${7}"

    grep -v POOLURL ${7} > tempedit && mv tempedit ${7}
    echo "POOLURL=${3}" >> "${7}"

    grep -v CPUPOOLPORT ${7} > tempedit && mv tempedit ${7}
    echo "CPUPOOLPORT=${4}" >> "${7}"
    grep -v GPUPOOLPORT ${7} > tempedit && mv tempedit ${7}
    echo "GPUPOOLPORT=${5}" >> "${7}"

    grep -v ALGO ${7} > tempedit && mv tempedit ${7}
    echo "ALGO=${6}" >> "${7}"

    # update .conf and set a local store
    # cat "${7}" > "${8}/${LOCALSTORAGE}"
}


# ${1} filename (.conf)
# ${2} MINERCONF
minerConfInputs () {
    clear

    echo
    echo
    echo "Enter the following info about your mining pool:"
    echo " this will be set in: ${2}/miner.conf"
    sleep 1
    echo "    Username (or wallet address)  "
    read miningpoolusername
    echo "    Password "
    read miningpoolpassword
    echo "    Pool URL"
    echo "      (example: stratum+tcp://stratum-asia.mintpond.com)"
    read miningpoolurl
    echo "    CPU Pool Port"
    echo "      (example: 3000)"
    read miningpoolcpuport
    echo "    Graphics (GPU) Pool Port"
    echo "      (example: 3001 [for optional stronger difficulty])"
    read miningpoolgpuport
    echo "    Algo"
    echo "      (example: lyra2z)"
    read miningpoolalgo

    updateMinerConf $miningpoolusername \
        $miningpoolpassword \
        $miningpoolurl \
        $miningpoolcpuport \
        $miningpoolgpuport \
        $miningpoolalgo \
        ${1} \
        ${2}
}

# ${1} filename (.conf)
# ${2} MINERCONF
updateMinerConfUI () {

    # clear
    localstoragedata="${2}/${LOCALSTORAGE}"

    # echo ${1} ${2}
    # echo ${1}
    # echo ${2}

    # if [ -f $localstoragedata ]; then
    #     read -p "  do you want to load your last mining pool config? (y/n) " loadpoolconfig
    #     case "$loadpoolconfig" in
    #         y|Y ) echo
    #         echo "loading previous config..."
    #         cat "${1}" > "${2}/miner.conf"
    #         cat "$localstoragedata" >> "${2}/miner.conf"
    #         echo;;
    #         * ) cat "${1}" > "${2}/miner.conf"
    #         minerConfInputs ${1} ${2};;
    #     esac
    # else
    #     cat "${1}" > "${2}/miner.conf"
        minerConfInputs ${1} ${2}/miner.conf
    # fi
}

