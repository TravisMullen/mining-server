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
# ${8} path to .conf
updateMinerConf () {
    sudo bash -c 'cat "${7}" > "${8}/${LOCALSTORAGE}"'

    grep -v MINERUSERNAME ${7} > tempedit && mv tempedit ${7}
    sudo bash -c 'echo "MINERUSERNAME=${1}" >> "${7}"'
    sudo bash -c 'echo "MINERUSERNAME=${1}" >> "${8}/${LOCALSTORAGE}"'

    grep -v MINERPASSWORD ${7} > tempedit && mv tempedit ${7}
    sudo bash -c 'echo "MINERPASSWORD=${2}" >> "${7}"'
    sudo bash -c 'echo "MINERPASSWORD=${2}" >> "${8}/${LOCALSTORAGE}"'

    grep -v POOLURL ${7} > tempedit && mv tempedit ${7}
    sudo bash -c 'echo "POOLURL=${3}" >> "${7}"'
    sudo bash -c 'echo "POOLURL=${3}" >> "${8}/${LOCALSTORAGE}"'

    grep -v CPUPOOLPORT ${7} > tempedit && mv tempedit ${7}
    sudo bash -c 'echo "CPUPOOLPORT=${4}" >> "${7}"'
    sudo bash -c 'echo "CPUPOOLPORT=${4}" >> "${8}/${LOCALSTORAGE}"'
    grep -v GPUPOOLPORT ${7} > tempedit && mv tempedit ${7}
    sudo bash -c 'echo "GPUPOOLPORT=${5}" >> "${7}"'
    sudo bash -c 'echo "GPUPOOLPORT=${5}" >> "${8}/${LOCALSTORAGE}"'

    grep -v ALGO ${7} > tempedit && mv tempedit ${7}
    sudo bash -c 'echo "ALGO=${6}" >> "${7}"'
    sudo bash -c 'echo "ALGO=${6}" >> "${8}/${LOCALSTORAGE}"'
    
}


# ${1} filename (.conf)
# ${2} MINERCONF FILE
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

    if [ -f $localstoragedata ]; then
        read -p "  do you want to load your last mining pool config? (y/n) " loadpoolconfig
        case "$loadpoolconfig" in
            y|Y )  sudo bash -c 'cat "${1}" > "${2}/miner.conf"'
            echo "loading previous config..."
            echo
            sleep 0.5
            sudo bash -c 'cat $localstoragedata >> "${2}/miner.conf"'
            sleep 1
            echo;;
            * ) sudo bash -c 'cat "${1}" > "${2}/miner.conf"'
            minerConfInputs ${2}/miner.conf ${2};;
        esac
    else
        sudo bash -c 'cat "${1}" > "${2}/miner.conf"'
        minerConfInputs ${2}/miner.conf ${2}
    fi
}

