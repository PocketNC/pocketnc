# Pocket NC 

This respository contains all the settings and software required to setup MachineKit on a BeagleBone Black for
controlling the Pocket NC v2.

*This document is in progress, it may not be complete or correct*

## Setup a BeagleBone Black for use in a Pocket NC v2

### flash bbb with latest machinekit image

### Set up pocketnc user

We're going to change the machinekit user name to pocketnc by creating a temporary
user, giving it sudo privileges, changing the machinekit user to pocketnc using the
temporary user, then deleting the temporary user.

    # may be 192.168.7.2, use username/password machinekit/machinekit
    ssh machinekit@192.168.6.2 
    sudo adduser temporary
    sudo adduser temporary sudo
    exit

    ssh temporary@192.168.6.2

    # The next command will error if there are any processes running owned by the machinekit user. 
    # It will list the process id. Run `kill <process id>` for every process until the following command goes through.
    sudo usermod -l pocketnc machinekit
    sudo usermod -d /home/pocketnc -m pocketnc
    exit

    # password should still be machinekit
    ssh pocketnc@192.168.6.2

    # change password to pocketnc (or whatever you like)
    passwd

    sudo deluser temporary
    sudo rm -r /home/temporary
    sudo ln -s /home/pocketnc /home/machinekit

### Change boot message

    sudo vim /etc/issue.net

Set it to something like:
   
    Debian GNU/Linux 8

    Pocket NC Image (based on MachineKit 4.14 image 11/19/2017)

    Support/FAQ: http://www.pocketnc.com/faq

    default username:password is [pocketnc:pocketnc]

### Set up DHCP on eth0

    # Uncomment line #iface eth0 inet dhcp in /etc/network/interfaces
    sudo sed -i 's/^#iface eth0 inet dhcp$/iface eth0 inet dhcp/' /etc/network/interfaces

### Update hostname

    # Change hostname from beaglebone to pocketnc
    sudo sed -i 's/beaglebone/pocketnc/g' /etc/hosts
    sudo sed -i 's/beaglebone/pocketnc/g' /etc/hostname
    sudo reboot

### Other Setup

    # disable lightdm (the windowing system)
    sudo systemctl disable lightdm

### Update the kernel

    cd /opt/scripts/tools/
    sudo ./update_kernel.sh --bone-rt-channel --lts-4_14
    sudo reboot

### Install dependencies for Rockhopper

    sudo pip install tornado # currently 4.5.2
    sudo apt-get install graphviz graphviz-dev # 2.38.0-7
    sudo pip install pygraphviz --install-option="--include-path=/usr/include/graphviz/" --install-option="--library-path=/usr/lib/graphviz"
    sudo pip install netifaces

### Clone this repository including submodules and run init scripts

    git clone --recursive https://github.com/PocketNC/pocketnc.git
    cd pocketnc
    sudo ./enableServices.sh
    ./postUpdate.sh

### Enable uBoot overlay

    sudo sed -i 's/^#uboot_overlay_addr0=\/lib\/firmware\/<file0>.dtbo$/uboot_overlay_addr0=\/lib\/firmware\/PocketNCdriver-00A0.dtbo/' /boot/uEnv.txt
    sudo sed -i 's/^#uboot_overlay_addr1=\/lib\/firmware\/<file1>.dtbo$/uboot_overlay_addr1=\/lib\/firmware\/BB-ADC-00A0.dtbo/' /boot/uEnv.txt
