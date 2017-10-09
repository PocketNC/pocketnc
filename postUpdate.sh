#!/bin/bash

./copyDefaultFiles.py

cd Settings
sudo ./dtc.sh
cd ..

sudo systemctl --system daemon-reload
