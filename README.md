```sh
              ___
             .-' \\".
            /`    ;--:
           |     (  (_)==
           |_ ._ '.__.;
           \_/`--_---_(
            (`--(./-\.)
            `|     _\ |
             | \  __ /
            /|  '.__/
         .'` \     |_
        /     '-__ / `- Ubuntu Linux
    ___  ____       _             
    |  \/  (_)     (_)            
    | .  . |_ _ __  _ _ __   __ _ 
    | |\/| | | '_ \| | '_ \ / _` |
    | |  | | | | | | | | | | (_| |
    \_|  |_/_|_| |_|_|_| |_|\__, |
     _____                   __/ |
    /  ___|                 |___/ 
    \ `--.  ___ _ ____   _____ _ __ 
     `--. \/ _ \ '__\ \ / / _ \ '__|
    /\__/ /  __/ |   \ V /  __/ |_  
    \____/ \___|_|    \_/ \___|_(_) 
                                

    this one is dedicated to all the miners
    in discord that told me a had to use Windows.
                                 
                                - 🖕


```
# Automated NVIDIA Graphics & CPU Mining
## Easy 💁‍♀️, Stable 🏋️‍♀️, High Hashrates ⛏🚀🌝.

Developed and tested on: **Ubuntu Server 16.04**

## Feaures
- Graphics (GPU) Miner, [ccminer](https://github.com/tpruvot/ccminer) &mdash; CUDA miner project, compatible with most nvidia cards.
- CPU Miner, [cpuminer-opt](https://github.com/JayDDee/cpuminer-opt) &mdash; Optimized multi algo CPU miner.
- Automatic start (and restart) of miner scripts.
- Miner information displayed as 'dashboard' on user login, with option to immediately tail active logs.
- CPU or GPU miner restart logs.
- **No Microsoft Windows Software**

# prerequisite.
1. Download and install [Ubuntu Server 16.04](http://releases.ubuntu.com/16.04.4/ubuntu-16.04.4-server-amd64.iso) with persistance (install onto disk or USB).
2. Install [OpenSSH Server](https://help.ubuntu.com/lts/serverguide/openssh-server.html). Consider taking additional steps to properly [secure your server](https://www.linode.com/docs/security/securing-your-server/).
```sh
sudo apt install openssh-server
``` 
3. [SSH](https://www.digitalocean.com/community/tutorials/how-to-use-ssh-to-connect-to-a-remote-server-in-ubuntu) into your host server and you are ready to run the install scripts below.

# install.
requires `sudo` permissions

```sh 
git clone https://github.com/TravisMullen/mining-server.git
cd mining-server
chmod +x ./*.sh
sudo ./install.sh 
```
### install script as one line.
`git clone https://github.com/TravisMullen/mining-server.git && cd mining-server && chmod +x ./*.sh && sudo ./install.sh `


# after install.

1. `sudo reboot` 
2. If install correctly the miners will start within a few minutes of boot.
    - Graphics (GPU) Miner will auto-start after 2 minutes of being inactive.
    - CPU Miner will auto-start after 10 minutes of being inactive.

3. Check status auto-start system [M/Monit](https://mmonit.com/). 
    - `sudo monit status` for entire server status.
    - `sudo monit status gpu-miner` for gpu miner status only.
    - `sudo monit status cpu-miner` for cpu miner status only.

## Miner Aliases (available, but never really needed)

```bash
alias startgpu="sudo ./start-gpu-miner.sh"
alias startcpu="sudo ./start-cpu-miner.sh"

alias stopgpu="sudo ./stop-gpu-miner.sh"
alias stopcpu="sudo ./stop-cpu-miner.sh"

alias startminers="startgpu && startcpu"
alias stopminers="stopgpu && stopcpu"
```