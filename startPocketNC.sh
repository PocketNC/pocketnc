#!/bin/bash

sudo /opt/pocketnc/ensureBootloaderUpToDate.sh

if [ -f /opt/pocketnc/Settings/PocketNC.ini ];then
  rm /opt/pocketnc/Settings/PocketNC.ini
fi

if [ -f /home/pocketnc/.pocketnc_env ]; then
  source /home/pocketnc/.pocketnc_env
fi

export PATH=$PATH:${POCKETNC_DIRECTORY}Settings

cd ${POCKETNC_DIRECTORY}Settings/

./generateINI.py

linuxcnc ${POCKETNC_DIRECTORY}Settings/PocketNC.ini
