#!/bin/bash

sudo ${POCKETNC_DIRECTORY}ensureBootloaderUpToDate.sh

if [ -f ${POCKETNC_DIRECTORY}Settings/PocketNC.ini ];then
  rm ${POCKETNC_DIRECTORY}Settings/PocketNC.ini
fi

if [ -f ${POCKETNC_DIRECTORY}../.pocketnc_env ]; then
  source ${POCKETNC_DIRECTORY}../.pocketnc_env
fi

export PATH=$PATH:${POCKETNC_DIRECTORY}Settings

cd ${POCKETNC_DIRECTORY}Settings/

./generateINI.py

linuxcnc ${POCKETNC_DIRECTORY}Settings/PocketNC.ini
