# Pocket NC 

This respository contains all the settings and software required to setup MachineKit on a BeagleBone Black for
controlling the Pocket NC v2.

*This document is in progress, it may not be complete or correct*

## Setup a BeagleBone Black for use in a Pocket NC v2

### Flash BBB with latest MachineKit image

    # with wget
    wget https://rcn-ee.com/rootfs/bb.org/testing/2017-02-12/machinekit/bone-debian-8.7-machinekit-armhf-2017-02-12-4gb.img.xz

    # with curl
    curl -O https://rcn-ee.com/rootfs/bb.org/testing/2017-02-12/machinekit/bone-debian-8.7-machinekit-armhf-2017-02-12-4gb.img.xz

    xzcat bone-debian-8.7-machinekit-armhf-2017-02-12-4gb.img.xz > bone-debian-8.7-machinekit-armhf-2017-02-12-4gb.img

    # on linux /dev/sdX on Mac /dev/rdiskX (on Mac you can use diskutil list to find what X is, make sure you use diskutil unmountDisk /dev/diskX)
    sudo dd bs=1m if=bone-debian-8.7-machinekit-armhf-2017-02-12-4gb.img of=/dev/<sdcard>

Insert the SD card into the BBB and power it on over USB. Connect to the BBB and enable the flasher script on boot. Then reboot to flash the image.

    ssh machinekit@192.168.7.2
    sudo sed -i 's/^#cmdline=init=\/opt\/scripts\/tools\/eMMC\/init-eMMC-flasher-v3.sh$/cmdline=init=\/opt\/scripts\/tools\/eMMC\/init-eMMC-flasher-v3.sh/' /boot/uEnv.txt
    sudo reboot

### Set up pocketnc user

We're going to change the machinekit user name to pocketnc by creating a temporary
user, giving it sudo privileges, changing the machinekit user to pocketnc using the
temporary user, then deleting the temporary user.

    # use username/password machinekit/machinekit
    ssh machinekit@192.168.7.2 
    sudo adduser temporary
    sudo adduser temporary sudo
    exit

    ssh temporary@192.168.7.2

    # The next command will error if there are any processes running owned by the machinekit user. 
    # It will list the process id. Run `sudo kill <process id>` for every process until the following command goes through.
    sudo usermod -l pocketnc machinekit
    sudo usermod -d /home/pocketnc -m pocketnc
    exit

    # password should still be machinekit
    ssh pocketnc@192.168.7.2

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

    Pocket NC Image (based on Machinekit Debian Image 2017-02-12)

    Support/FAQ: http://www.pocketnc.com/faq

    default username:password is [pocketnc:pocketnc]
    EOF"

    sudo cp /etc/issue.net /etc/issue

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
    sudo systemctl stop lightdm

### Disable Apache

    sudo systemctl disable apache2
    sudo systemctl stop apache2


### Install dependencies for Rockhopper

    sudo pip install tornado==4.5.2
    sudo apt-get install graphviz graphviz-dev # 2.38.0-7
    sudo pip install pygraphviz --install-option="--include-path=/usr/include/graphviz/" --install-option="--library-path=/usr/lib/graphviz"
    sudo pip install netifaces

### Clone this repository including submodules and run init scripts

    git clone -b latestMachineKitTest --recursive https://github.com/PocketNC/pocketnc.git
    cd pocketnc
    sudo ./enableServices.sh
    ./postUpdate.sh

    mkdir ~/ncfiles

    sudo reboot
