# Pocket NC 

This respository contains all the settings and software required to setup MachineKit on a BeagleBone Black for
controlling the Pocket NC v2.

*This document is in progress, it may not be complete or correct*

## Setup a BeagleBone Black for use in a Pocket NC v2

### Flash BBB with latest MachineKit image

    # with wget
    wget https://rcn-ee.net/rootfs/bb.org/testing/2017-12-12/stretch-machinekit/bone-debian-9.3-machinekit-armhf-2017-12-12-4gb.img.xz

    # with curl
    curl -O https://rcn-ee.net/rootfs/bb.org/testing/2017-12-12/stretch-machinekit/bone-debian-9.3-machinekit-armhf-2017-12-12-4gb.img.xz

Use [Etcher](https://etcher.io/) to flash image to SD Card.
Insert the SD card into the BBB and power it on over USB. Connect to the BBB and enable the flasher script on boot. Then reboot to flash the image.

    ssh machinekit@192.168.6.2 # 192.168.7.2 on Windows
    sudo sed -i 's/^#cmdline=init=\/opt\/scripts\/tools\/eMMC\/init-eMMC-flasher-v3.sh$/cmdline=init=\/opt\/scripts\/tools\/eMMC\/init-eMMC-flasher-v3.sh/' /boot/uEnv.txt
    sudo reboot

### Set up pocketnc user

We're going to change the machinekit user name to pocketnc by creating a temporary
user, giving it sudo privileges, changing the machinekit user to pocketnc using the
temporary user, then deleting the temporary user.

    # use username/password machinekit/machinekit
    ssh machinekit@192.168.6.2 # 192.168.7.2 on Windows
    sudo adduser temporary
    sudo adduser temporary sudo
    exit

    ssh temporary@192.168.6.2 # 192.168.7.2 on Windows

    # The next command will error if there are any processes running owned by the machinekit user. 
    # It will list the process id. Run `sudo kill <process id>` for every process until the following command goes through.
    sudo usermod -l pocketnc machinekit
    sudo usermod -d /home/pocketnc -m pocketnc
    exit

    # password should still be machinekit
    ssh pocketnc@192.168.6.2 # 192.168.7.2 on Windows

    # change password to pocketnc (or whatever you like)
    passwd

    # Setup no password for sudo
    # on the last line change machinekit to pocketnc
    # it should look like (no #):
    # pocketnc ALL=NOPASSWD: ALL
    sudo visudo

    sudo deluser temporary
    sudo rm -r /home/temporary
    sudo ln -s /home/pocketnc /home/machinekit

### Change boot message

    sudo sh -c "cat <<EOF > /etc/issue.net
    Debian GNU/Linux 8

    Pocket NC Image (based on https://rcn-ee.net/rootfs/bb.org/testing/2017-12-12/stretch-machinekit/bone-debian-9.3-machinekit-armhf-2017-12-12-4gb.img.xz)

    Support/FAQ: http://www.pocketnc.com/faq

    default username:password is [pocketnc:pocketnc]
    EOF"

    sudo cp /etc/issue.net /etc/issue

### Set up DHCP on eth0

    # Uncomment line #iface eth0 inet dhcp in /etc/network/interfaces
    sudo sed -i 's/^#iface eth0 inet dhcp$/iface eth0 inet dhcp/' /etc/network/interfaces

### Update hostname

    # Change hostname from beaglebone to pocketnc
    sudo sed -i 's/beaglebone/pocketnc/g' /etc/hosts
    sudo sed -i 's/beaglebone/pocketnc/g' /etc/hostname

### Reboot (make sure ethernet is plugged in)

    sudo reboot

### Update apt-get

    sudo apt-get update
    sudo apt-get upgrade

### Disable graphical boot

    # disable lightdm (the windowing system)
    sudo systemctl disable lightdm

### Disable Apache

    sudo systemctl disable apache2
    sudo systemctl stop apache2

### Install dependencies for Rockhopper

    sudo pip install tornado # currently 4.5.2
    sudo apt-get install graphviz graphviz-dev # 2.38.0-7
    sudo pip install pygraphviz --install-option="--include-path=/usr/include/graphviz/" --install-option="--library-path=/usr/lib/graphviz"
    sudo pip install netifaces

### Set the kernel to 4.4

    cd /opt/scripts/tools/
    sudo ./update_kernel.sh --ti-rt-channel --lts-4_4
    sudo reboot

### Clone this repository including submodules and run init scripts

    git clone --recursive https://github.com/PocketNC/pocketnc.git
    cd pocketnc
    sudo ./enableServices.sh
    ./postUpdate.sh

    mkdir ~/ncfiles

### Enable uBoot overlay

    sudo sed -i 's/^#uboot_overlay_addr0=\/lib\/firmware\/<file0>.dtbo$/uboot_overlay_addr0=\/lib\/firmware\/PocketNCdriver-00A0.dtbo/' /boot/uEnv.txt

### Disable HDMI Audio (P9.28 in use by Pocket NC)

    sudo sed -i 's/^#disable_uboot_overlay_audio=1/disable_uboot_overlay_audio=1/' /boot/uEnv.txt

### Reboot

    sudo reboot
