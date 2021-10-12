#!/bin/bash


echo "Running firstBoot.sh..."

# Might be safer to do this on the second boot after the
# partition has been expanded
${POCKETNC_DIRECTORY}/copyFilesFromEMMC.sh

if cat /proc/device-tree/model | grep -i -q "AM335x"; then
  echo "Found AM335x, installing bb-u-boot-am335x-evm"
  sudo /opt/u-boot/bb-u-boot-am335x-evm/install.sh
fi

if cat /proc/device-tree/model | grep -i -q "AM57"; then
  echo "Found AM57xx, installing bb-u-boot-am335x-evm"
  sudo /opt/u-boot/bb-u-boot-am57xx-evm/install.sh
fi

sudo rm /var/pnc-first-boot

sudo /opt/scripts/tools/grow_partition.sh

sudo reboot
