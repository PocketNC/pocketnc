#!/bin/bash

preUpdate.sh $1

git checkout tags/$1
git submodule update

postUpdate.sh $1

sudo shutdown -r now
