#!/bin/bash

echo "Reloading services..."
sudo systemctl --system daemon-reload

echo "Killing Rockhopper..."
sudo systemctl stop Rockhopper.service

echo "Killing PocketNC..."
sudo systemctl stop PocketNC.service

sleep 1

echo "Starting PocketNC..."
sudo systemctl start PocketNC.service

echo "Starting Rockhopper..."
sudo systemctl start Rockhopper.service
