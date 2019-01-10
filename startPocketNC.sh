#!/bin/bash

if [ -f /home/pocketnc/.pocketnc_env ]; then
  source /home/pocketnc/.pocketnc_env
fi

export PATH=$PATH:/home/pocketnc/pocketnc/Settings

/home/pocketnc/pocketnc/Settings/generateINI.py

linuxcnc /home/pocketnc/pocketnc/Settings/PocketNC.ini
