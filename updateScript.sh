#!/bin/bash

git checkout tags/$1
git submodule update

/home/pocketnc/pocketnc/copyDefaultFiles.py
sudo /home/pocketnc/pocketnc/Settings/dtc.sh

sudo shutdown -r now
