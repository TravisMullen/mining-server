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
                        /     '-__ / `-
    ___  ____       _             _____                          
    |  \/  (_)     (_)           /  ___|                         
    | .  . |_ _ __  _ _ __   __ _\ `--.  ___ _ ____   _____ _ __ 
    | |\/| | | '_ \| | '_ \ / _` |`--. \/ _ \ '__\ \ / / _ \ '__|
    | |  | | | | | | | | | | (_| /\__/ /  __/ |   \ V /  __/ |_  
    \_|  |_/_|_| |_|_|_| |_|\__, \____/ \___|_|    \_/ \___|_(_) 
                             __/ |                               
                            |___/                                
                                     
```
## NVIDIA Graphics & CPU Mining

Feaures:
- GPU Mining for NVIDIA 10 Series graphics cards.
- CPU Mining for most CPU processors (ARM not supported).
- Automatic start (and restart) of miner scripts.
- Miner information displayed on user login, with option to tail active logs.

...supports Nvidia GPUs
   and (most) CPUs.

  Only tested/supported for:
  Ubuntu Server 16.04

# install script.
### requires `sudo` permissions

```sh 
git clone https://github.com/TravisMullen/mining-server.git
cd mining-server
chmod +x ./*.sh
sudo ./install.sh 
```
## install script as one line.
`git clone https://github.com/TravisMullen/mining-server.git && cd mining-server && chmod +x ./*.sh && sudo ./install.sh `

## Miner Aliases

```bash
alias startgpu="sudo ./start-gpu-miner.sh"
alias startcpu="sudo ./start-cpu-miner.sh"

alias stopgpu="sudo ./stop-gpu-miner.sh"
alias stopcpu="sudo ./stop-cpu-miner.sh"

alias startminers="startgpu && startcpu"
alias stopminers="stopgpu && stopcpu"
```