#!/bin/bash

pgrep -f "python /home/pocketnc/pocketnc/Rockhopper/LinuxCNCWebSktSvr.py" | while read -r pid ; do
  echo "killing $pid"
  kill -9 $pid
done
