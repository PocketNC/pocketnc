#!/bin/bash

if [ -f /home/pocketnc/.pocketnc_env ]; then
  source /home/pocketnc/.pocketnc_env
fi

sleep 1
while [ ! -f /home/pocketnc/pocketnc/Settings/PocketNC.ini ];
do
  echo "Waiting for PocketNC.ini file to be generated..."
  sleep 1
done

python /home/pocketnc/pocketnc/Rockhopper/LinuxCNCWebSktSvr.py /home/pocketnc/pocketnc/Settings/PocketNC.ini
