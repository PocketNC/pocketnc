#!/bin/bash

if [ -b /dev/mmcblk1p1 ]; then
  sudo mount /dev/mmcblk1p1 /mnt

  if [ -f /mnt/home/pocketnc/pocketnc/Settings/CalibrationOverlay.inc ]; then
    cp /mnt/home/pocketnc/pocketnc/Settings/CalibrationOverlay.inc ${POCKETNC_VAR_DIRECTORY}/CalibrationOverlay.inc
    python3 ${POCKETNC_DIRECTORY}/Rockhopper/convertCalibrationOverlay.py ${POCKETNC_VAR_DIRECTORY}/CalibrationOverlay.inc
  fi

  if [ -f /mnt/home/pocketnc/pocketnc/Settings/a.comp ]; then
    cp /mnt/home/pocketnc/pocketnc/Settings/a.comp ${POCKETNC_VAR_DIRECTORY}/a.comp
  fi

  if [ -f /mnt/home/pocketnc/pocketnc/Settings/b.comp ]; then
    cp /mnt/home/pocketnc/pocketnc/Settings/b.comp ${POCKETNC_VAR_DIRECTORY}/b.comp
  fi

  if [ -f /mnt/home/pocketnc/pocketnc/Settings/c.comp ]; then
    cp /mnt/home/pocketnc/pocketnc/Settings/c.comp ${POCKETNC_VAR_DIRECTORY}/c.comp
  fi

  if [ -f /mnt/home/pocketnc/pocketnc/Settings/tool.tbl ]; then
    cp /mnt/home/pocketnc/pocketnc/Settings/tool.tbl ${POCKETNC_VAR_DIRECTORY}/tool.tbl
  fi

  if [ -d /mnt/home/pocketnc/ncfiles ]; then
    cp -r /mnt/home/pocketnc/ncfiles/* /home/pocketnc/ncfiles/
  fi
fi
