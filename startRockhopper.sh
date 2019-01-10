#!/bin/bash

if [ -f /home/pocketnc/.pocketnc_env ]; then
  source /home/pocketnc/.pocketnc_env
fi

python /home/pocketnc/pocketnc/Rockhopper/LinuxCNCWebSktSvr.py /home/pocketnc/pocketnc/Settings/PocketNC.ini
