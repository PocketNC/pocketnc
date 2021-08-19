#!/bin/bash

pgrep -f "linuxcnc-python ${POCKETNC_DIRECTORY}/Rockhopper/LinuxCNCWebSktSvr.py" | while read -r pid ; do
  echo "Killing LinuxCNCWebSktSvr.py $pid"
  kill $pid
done

rockhopper_pid=$(pgrep -f "linuxcnc-python ${POCKETNC_DIRECTORY}/Rockhopper/LinuxCNCWebSktSvr.py" )
waitCount=0

while [ -n "$rockhopper_pid" ] && (( $waitCount < 30 )); do 
  rockhopper_pid=$(pgrep -f "linuxcnc-python ${POCKETNC_DIRECTORY}/Rockhopper/LinuxCNCWebSktSvr.py" )
  sleep .1;
  let waitCount++
done

pgrep -f "linuxcnc-python ${POCKETNC_DIRECTORY}/Rockhopper/LinuxCNCWebSktSvr.py" | while read -r pid ; do
  echo "Timeout expired, force killing Rockhopper $pid"
  kill -9 $pid
done

