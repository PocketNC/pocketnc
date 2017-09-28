#!/bin/bash

ln -s /home/pocketnc/pocketnc/Rockhopper.service /etc/systemd/system/multi-user.target.wants/Rockhopper.service
ln -s /home/pocketnc/pocketnc/PocketNC.service /etc/systemd/system/multi-user.target.wants/PocketNC.service
ln -s /home/pocketnc/pocketnc/pocketnc-ui.service /etc/systemd/system/multi-user.target.wants/pocketnc-ui.service
