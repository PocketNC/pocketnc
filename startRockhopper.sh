#!/bin/bash

if [ -f /home/pocketnc/.pocketnc_env ]; then
  source /home/pocketnc/.pocketnc_env
fi

sleep 1

dummy_pid=$(pgrep dummy.sh)
until [ -n "$dummy_pid" ]; do
  echo "Waiting for dummy.sh before starting LinuxCNCWebSktSvr..."
  dummy_pid=$(pgrep dummy.sh)
  sleep 1
done

linuxcnc-python /home/pocketnc/pocketnc/Rockhopper/LinuxCNCWebSktSvr.py /home/pocketnc/pocketnc/Settings/PocketNC.ini
