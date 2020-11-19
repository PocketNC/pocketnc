#!/bin/bash

./copyDefaultFiles.py

# Check if swap space is being used
if [ -f /my_swap ]; then
  if grep --quiet /my_swap /etc/fstab; then
    echo "Swap space already being allocated at boot"
  else
    sudo mkswap /my_swap
    sudo swapon /my_swap
    sudo su -c 'echo "/my_swap swap swap defaults 0 0" >> /etc/fstab'
  fi
fi

./ensureTmpRemotesAdded.sh
./ensurePublicKeysAdded.sh

cd /opt/scripts/boot

sudo git fetch origin
sudo git checkout b61125c1485bee929340cacc06c85c6fcfd678bc

cd ~/pocketnc/Settings

if [ -x ./dtc.sh ]; then
  sudo ./dtc.sh
fi

if [ -x ./postUpdate ]; then
  ./postUpdate
fi

cd ..

sudo systemctl --system daemon-reload
