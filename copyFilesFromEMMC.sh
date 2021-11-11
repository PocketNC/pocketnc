#!/bin/bash

if [ -b /dev/mmcblk1p1 ]; then
  sudo mount /dev/mmcblk1p1 /mnt

  # Handles calibration data for machines made afer August 2019
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

  sudo umount /mnt
fi

if [ -b /dev/mmcblk1p2 ]; then
  sudo mount /dev/mmcblk1p2 /mnt

  # Handles v1 calibration data
  if [ -f /mnt/home/pocketnc/linuxcnc/configs/ARM.BeagleBone.PocketNC/PocketNC.ini ]; then
    python3 ${POCKETNC_DIRECTORY}/Rockhopper/convertV1INIFileToOverlay.py \
            /mnt/home/pocketnc/linuxcnc/configs/ARM.BeagleBone.PocketNC/PocketNC.ini \
            ${POCKETNC_DIRECTORY}/Settings/versions/v1revH/PocketNC.ini \
            ${POCKETNC_VAR_DIRECTORY}/CalibrationOverlay.inc
    echo v1revH > ${POCKETNC_VAR_DIRECTORY}/version
  fi

  if [ -d /mnt/home/pocketnc/linuxcnc/nc_files ]; then
    cp -r /mnt/home/pocketnc/linuxcnc/nc_files/*.ngc /home/pocketnc/ncfiles/
  fi

  # Handles calibration data for v2 machines made prior to September 2019
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
  sudo umount /mnt
fi
