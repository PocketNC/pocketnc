#!/bin/bash

if [ -f /opt/pocketnc/pocketnc_env ]; then
  source /opt/pocketnc/pocketnc_env
fi
if [ -f /home/pocketnc/.pocketnc_env ]; then
  source /home/pocketnc/.pocketnc_env
fi

sudo ${POCKETNC_DIRECTORY}/ensureBootloaderUpToDate.sh

if [ -f ${POCKETNC_VAR_DIRECTORY}/PocketNC.ini ];then
  rm ${POCKETNC_VAR_DIRECTORY}/PocketNC.ini
fi

export PATH=$PATH:${POCKETNC_DIRECTORY}/Settings

cd ${POCKETNC_DIRECTORY}/Settings/

./generateINI.py

linuxcnc ${POCKETNC_VAR_DIRECTORY}/PocketNC.ini
