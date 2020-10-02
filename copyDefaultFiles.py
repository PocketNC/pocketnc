#!/usr/bin/python 

import subprocess
import os
import shutil

ROOT_DIRECTORY = "/home/pocketnc/pocketnc"
TOOL_TABLE_FILE = os.path.join(ROOT_DIRECTORY, "Settings/tool.tbl")
TOOL_TABLE_DEFAULT_FILE = os.path.join(ROOT_DIRECTORY, "Settings/tool.tbl.default")

CLIENT_CONFIG_FILE = os.path.join(ROOT_DIRECTORY, "Rockhopper/CLIENT_CONFIG.JSON")
CLIENT_CONFIG_DEFAULT_FILE = os.path.join(ROOT_DIRECTORY, "Rockhopper/CLIENT_CONFIG.JSON.default")

A_COMP_FILE = os.path.join(ROOT_DIRECTORY, "Settings/a.comp");
A_COMP_DEFAULT_FILE = os.path.join(ROOT_DIRECTORY, "Settings/a.comp.default");

B_COMP_FILE = os.path.join(ROOT_DIRECTORY, "Settings/b.comp");
B_COMP_DEFAULT_FILE = os.path.join(ROOT_DIRECTORY, "Settings/b.comp.default");

C_COMP_FILE = os.path.join(ROOT_DIRECTORY, "Settings/c.comp");
C_COMP_DEFAULT_FILE = os.path.join(ROOT_DIRECTORY, "Settings/c.comp.default");

if not os.path.isfile(A_COMP_FILE):
    shutil.copyfile(A_COMP_DEFAULT_FILE, A_COMP_FILE)

if not os.path.isfile(B_COMP_FILE):
    shutil.copyfile(B_COMP_DEFAULT_FILE, B_COMP_FILE)

if not os.path.isfile(C_COMP_FILE):
    shutil.copyfile(C_COMP_DEFAULT_FILE, C_COMP_FILE)

if not os.path.isfile(TOOL_TABLE_FILE):
    shutil.copyfile(TOOL_TABLE_DEFAULT_FILE, TOOL_TABLE_FILE)

if not os.path.isfile(CLIENT_CONFIG_FILE):
    shutil.copyfile(CLIENT_CONFIG_DEFAULT_FILE, CLIENT_CONFIG_FILE);
