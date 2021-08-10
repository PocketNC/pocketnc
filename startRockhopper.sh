#!/bin/bash

if [ -f ${POCKETNC_DIRECTORY}../.pocketnc_env ]; then
  source ${POCKETNC_DIRECTORY}../.pocketnc_env
fi

sleep 1

dummy_pid=$(pgrep dummy.sh)
until [ -n "$dummy_pid" ]; do
  echo "Waiting for dummy.sh before starting LinuxCNCWebSktSvr..."
  dummy_pid=$(pgrep dummy.sh)
  sleep 1
done

linuxcnc-python ${POCKETNC_DIRECTORY}Rockhopper/LinuxCNCWebSktSvr.py ${POCKETNC_DIRECTORY}Settings/PocketNC.ini
