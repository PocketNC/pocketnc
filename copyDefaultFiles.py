#!/usr/bin/python 

import subprocess
import os
import shutil

ROOT_DIRECTORY = "/home/pocketnc/pocketnc"
TOOL_TABLE_FILE = os.path.join(ROOT_DIRECTORY, "Settings/tool.tbl")
TOOL_TABLE_DEFAULT_FILE = os.path.join(ROOT_DIRECTORY, "Settings/tool.tbl.default")
CLIENT_CONFIG_FILE = os.path.join(ROOT_DIRECTORY, "Rockhopper/CLIENT_CONFIG.JSON")
CLIENT_CONFIG_DEFAULT_FILE = os.path.join(ROOT_DIRECTORY, "Rockhopper/CLIENT_CONFIG.JSON.default")

if not os.path.isfile(TOOL_TABLE_FILE):
    shutil.copyfile(TOOL_TABLE_DEFAULT_FILE, TOOL_TABLE_FILE)

if not os.path.isfile(CLIENT_CONFIG_FILE):
    shutil.copyfile(CLIENT_CONFIG_DEFAULT_FILE, CLIENT_CONFIG_FILE);
