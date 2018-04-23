# BANANA... LAMBIC!
## Simple ZCoin Mining Server Installer.

...supports Nvidia GPUs
   and (most) CPUs.

  Only tested/supported for:
  Ubuntu Server 16.04

# install.
### copy and paste below as user (requires `sudo` permissions)

```sh 
git clone https://travismullen@bitbucket.org/travismullen/xzc-gpu.git
cd xzc-gpu
chmod +x ./*.sh
sudo ./install.sh 
```

`git clone https://travismullen@bitbucket.org/travismullen/xzc-gpu.git && cd xzc-gpu && chmod +x ./*.sh && sudo ./install.sh `

## Miner Aliases

```bash
alias startgpu="sudo ./start-gpu-miner.sh"
alias startcpu="sudo ./start-cpu-miner.sh"

alias stopgpu="sudo ./stop-gpu-miner.sh"
alias stopcpu="sudo ./stop-cpu-miner.sh"

alias startminers="startgpu && startcpu"
alias stopminers="stopgpu && stopcpu"
```