#!/bin/bash

git checkout tags/$1
git submodule update

postUpdate.sh

sudo shutdown -r now
