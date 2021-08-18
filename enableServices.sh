#!/bin/bash

if [ -f /home/pocketnc/.pocketnc_env ]; then
  source /home/pocketnc/.pocketnc_env
fi

systemctl enable ${POCKETNC_DIRECTORY}Rockhopper.service
systemctl enable ${POCKETNC_DIRECTORY}PocketNC.service
#systemctl enable /home/pocketnc/pocketnc/pocketnc-ui.service
