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

# Check for internet connection. 
if ping -q -c 1 -W 1 github.com >/dev/null; then
  # Update /opt/scripts/boot to commit b61125c1485bee929340cacc06c85c6fcfd678bc
  # This commit changes the ethernet-over-usb protocol used with macOS from ECM
  # to NCM, because with v11 macOS no longer supports ECM
  cd /opt/scripts/boot
  sudo git fetch origin
  sudo git checkout b61125c1485bee929340cacc06c85c6fcfd678bc

  if ! dpkg -l | grep bb-usb-gadgets; then
    sudo apt update
    sudo apt install bb-usb-gadgets
  fi
else #If no connection, assume update is occuring over USB
  if [ -d /tmp/boot-scripts/ ]; then
    cd /opt/scripts/boot
    git remote add tmp /tmp/boot-scripts
    sudo git fetch tmp
    sudo git checkout b61125c1485bee929340cacc06c85c6fcfd678bc
  fi
  if [ -d /tmp/ ] && ! dpkg -l | grep bb-usb-gadgets; then
    sudo dpkg -i /tmp/debs/bb-usb-gadgets_1.20200504.0-0~stretch+20200504_all.deb
  fi
fi


# Prevent shared memory from being cleaned up when pocketnc user closes SSH
sudo sed -i 's/^#RemoveIPC=yes/RemoveIPC=no/' /etc/systemd/logind.conf
# Remove line which is incorrectly setting usb0 as default gateway from /etc/network/interfaces 
# ONLY IF bb-usb-gadgets IS INSTALLED. 
# We would rather have:
# - usb tethering working, network gateway broken
# than
# - network gateway working, usb tethering broken
if dpkg-query -s bb-usb-gadgets | grep "install ok installed"; then
  sudo sed -i 's/^\([^#]*gateway\)/#\1/g' /etc/network/interfaces
else
  sudo sed -i '/gateway/s/#//g' /etc/network/interfaces
fi


cd /home/pocketnc/pocketnc/Settings

if [ -x ./dtc.sh ]; then
  sudo ./dtc.sh
fi

if [ -x ./postUpdate ]; then
  ./postUpdate
fi

cd ..

sudo systemctl --system daemon-reload
