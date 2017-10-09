#!/bin/bash

echo "Reloading services..."
sudo systemctl --system daemon-reload

echo "Restarting PocketNC..."
sudo systemctl restart PocketNC.service

echo "Restarting Rockhopper..."
sudo systemctl restart Rockhopper.service
