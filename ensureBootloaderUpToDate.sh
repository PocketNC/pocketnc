
microSDVersion=""
emmcVersion=""

if [ -b /dev/mmcblk0 ] ; then
    dd if=/dev/mmcblk0 count=1 skip=1 bs=128k > /tmp/microSDBootloader.tmp 2>/dev/null
    microSDVersion=$(grep -a "U-Boot SPL" /tmp/microSDBootloader.tmp || true)
fi

if [ -b /dev/mmcblk1 ] ; then
    dd if=/dev/mmcblk1 count=1 skip=1 bs=128k > /tmp/emmcBootloader.tmp 2>/dev/null
    emmcVersion=$(grep -a "U-Boot SPL" /tmp/emmcBootloader.tmp || true)
fi

if [ "${microSDVersion}" != "" ] && [ "${microSDVersion}" != "${emmcVersion}" ]; then
  echo "microSD card bootloader different than eMMC, copying microSD card's bootloader to eMMC."
  if cat /proc/device-tree/model | grep -i -q "AM335x"; then
    echo "Found AM335x, installing bb-u-boot-am335x-evm"
    /opt/u-boot/bb-u-boot-am335x-evm/install.sh
    reboot
  fi

  if cat /proc/device-tree/model | grep -i -q "AM57"; then
    echo "Found AM57xx, installing bb-u-boot-am335x-evm"
    /opt/u-boot/bb-u-boot-am57xx-evm/install.sh
    reboot
  fi
else
  echo "Not copying bootloader from microSD to eMMC."
fi
