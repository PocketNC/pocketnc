#!/bin/bash

if [ -f /opt/pocketnc/pocketnc_env ]; then
  source /opt/pocketnc/pocketnc_env
fi
if [ -f /home/pocketnc/.pocketnc_env ]; then
  source /home/pocketnc/.pocketnc_env
fi

sudo ${POCKETNC_DIRECTORY}/ensureBootloaderUpToDate.sh

if [ ! -d ${POCKETNC_USB_DIRECTORY}/usb0 ]; then
  sudo mkdir -p ${POCKETNC_USB_DIRECTORY}/usb0
fi
if [ ! -d ${POCKETNC_USB_DIRECTORY}/usb1 ]; then
  sudo mkdir -p ${POCKETNC_USB_DIRECTORY}/usb1
fi
if [ ! -d ${POCKETNC_USB_DIRECTORY}/usb2 ]; then
  sudo mkdir -p ${POCKETNC_USB_DIRECTORY}/usb2
fi
if [ ! -d ${POCKETNC_USB_DIRECTORY}/usb3 ]; then
  sudo mkdir -p ${POCKETNC_USB_DIRECTORY}/usb3
fi
if [ ! -d ${POCKETNC_USB_DIRECTORY}/usb4 ]; then
  sudo mkdir -p ${POCKETNC_USB_DIRECTORY}/usb4
fi
if [ ! -d ${POCKETNC_USB_DIRECTORY}/usb5 ]; then
  sudo mkdir -p ${POCKETNC_USB_DIRECTORY}/usb5
fi
if [ ! -d ${POCKETNC_USB_DIRECTORY}/usb6 ]; then
  sudo mkdir -p ${POCKETNC_USB_DIRECTORY}/usb6
fi
if [ ! -d ${POCKETNC_USB_DIRECTORY}/usb7 ]; then
  sudo mkdir -p ${POCKETNC_USB_DIRECTORY}/usb7
fi

if [ -f ${POCKETNC_VAR_DIRECTORY}/PocketNC.ini ];then
  rm ${POCKETNC_VAR_DIRECTORY}/PocketNC.ini
fi

export PATH=$PATH:${POCKETNC_DIRECTORY}/Settings

cd ${POCKETNC_DIRECTORY}/Settings/

./generateINI.py

linuxcnc ${POCKETNC_VAR_DIRECTORY}/PocketNC.ini
