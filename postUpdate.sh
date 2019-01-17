#!/bin/bash

./copyDefaultFiles.py

cd Settings

if [ -x ./dtc.sh ]; then
  sudo ./dtc.sh
fi

if [ -x ./postUpdate ]; then
  ./postUpdate
fi

cd ..

sudo systemctl --system daemon-reload
