#!/bin/bash

echo "Reloading services..."
sudo systemctl --system daemon-reload

echo "Killing PocketNC..."
/home/pocketnc/pocketnc/stopPocketNC.sh
echo "Starting PocketNC..."
sudo systemctl start PocketNC.service

echo "Restarting Rockhopper..."
sudo systemctl restart Rockhopper.service
