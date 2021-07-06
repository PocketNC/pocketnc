#!/bin/bash

sudo /home/pocketnc/pocketnc/ensureBootloaderUpToDate.sh

if [ -f /home/pocketnc/pocketnc/Settings/PocketNC.ini ];then
  rm /home/pocketnc/pocketnc/Settings/PocketNC.ini
fi

if [ -f /home/pocketnc/.pocketnc_env ]; then
  source /home/pocketnc/.pocketnc_env
fi

export PATH=$PATH:/home/pocketnc/pocketnc/Settings

cd /home/pocketnc/pocketnc/Settings/

./generateINI.py

linuxcnc /home/pocketnc/pocketnc/Settings/PocketNC.ini
