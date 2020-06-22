#!/bin/bash

# Check for tmp remotes
if ! git remote -v | grep -q '/tmp/pocketnc'; then
  git remote add tmp /tmp/pocketnc
fi

cd Rockhopper
if ! git remote -v | grep -q '/tmp/pocketnc/Rockhopper'; then
  git remote add tmp /tmp/pocketnc/Rockhopper
fi
cd ..

cd pocketnc-ui
if ! git remote -v | grep -q '/tmp/pocketnc/pocketnc-ui'; then
  git remote add tmp /tmp/pocketnc/pocketnc-ui
fi
cd ..

cd Settings
if ! git remote -v | grep -q '/tmp/pocketnc/Settings'; then
  git remote add tmp /tmp/pocketnc/Settings
fi
cd ..
