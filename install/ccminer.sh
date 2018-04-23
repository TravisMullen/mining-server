#!/bin/bash -e

nvidia-smi
if test $? -eq 0
then
  echo "nvidia drivers are installed correctly"
else
  # nvidia drivers
  sudo apt-get remove nvidia* && sudo apt-get autoremove -y
  sudo add-apt-repository ppa:graphics-drivers/ppa -y
  sudo apt-get update -y
  # sudo ubuntu-drivers autoinstall

  sudo apt-get install nvidia-390 -y


  # CUDA 9.1
  wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
  sudo dpkg -i cuda-repo-ubuntu1604_9.1.85-1_amd64.deb
  sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
  sudo apt-get update
  sudo apt-get install cuda -y
fi

which ccminer
if test $? -eq 1
then
  # Install ccminer dependencies
  sudo apt-get install libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential -y

  # Ubuntu is now shipped with gcc 6 or 7 so please install gcc/g++ 5 and make it the default (required by the cuda toolkit)

  sudo apt-get install gcc-5 g++-5 -y
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 1

  git clone https://github.com/tpruvot/ccminer.git
  cd ccminer

  ./autogen.sh
  ./configure

  ./build.sh

  sudo cp ccminer /usr/bin/ccminer
fi

echo
echo
echo
echo
echo
echo "cciminer running from: $(which ccminer)"
echo
