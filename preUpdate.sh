#!/bin/bash

./applyOldOverlaySettings.py $1

cd Settings

if [ -x ./preUpdate ]; then
  ./preUpdate $1
fi

cd ..
