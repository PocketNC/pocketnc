#!/bin/bash

pgrep -f "linuxcnc /home/pocketnc/pocketnc/Settings/PocketNC.ini" | while read -r pid ; do
  echo "killing $pid"
  kill -9 $pid
done

pgrep -f "emcweb -ini /home/pocketnc/pocketnc/Settings/PocketNC.ini" | while read -r pid ; do
  echo "killing $pid"
  kill -9 $pid
done
