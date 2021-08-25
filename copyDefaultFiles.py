#!/usr/bin/python3

import subprocess
import os
import shutil

POCKETNC_DIRECTORY = os.environ.get('POCKETNC_DIRECTORY')
POCKETNC_VAR_DIRECTORY = os.environ.get('POCKETNC_VAR_DIRECTORY')
TOOL_TABLE_FILE = os.path.join(POCKETNC_VAR_DIRECTORY, "tool.tbl")
TOOL_TABLE_DEFAULT_FILE = os.path.join(POCKETNC_DIRECTORY, "Settings/tool.tbl.default")

POCKETNC_ENV_FILE = os.path.join(POCKETNC_DIRECTORY, "pocketnc_env")
POCKETNC_ENV_DEFAULT_FILE = os.path.join(POCKETNC_DIRECTORY, "pocketnc_env.default")

CLIENT_CONFIG_FILE = os.path.join(POCKETNC_VAR_DIRECTORY, "CLIENT_CONFIG.JSON")
CLIENT_CONFIG_DEFAULT_FILE = os.path.join(POCKETNC_DIRECTORY, "Rockhopper/CLIENT_CONFIG.JSON.default")

A_COMP_FILE = os.path.join(POCKETNC_VAR_DIRECTORY, "a.comp");
A_COMP_DEFAULT_FILE = os.path.join(POCKETNC_DIRECTORY, "Settings/a.comp.default");

B_COMP_FILE = os.path.join(POCKETNC_VAR_DIRECTORY, "b.comp");
B_COMP_DEFAULT_FILE = os.path.join(POCKETNC_DIRECTORY, "Settings/b.comp.default");

C_COMP_FILE = os.path.join(POCKETNC_VAR_DIRECTORY, "c.comp");
C_COMP_DEFAULT_FILE = os.path.join(POCKETNC_DIRECTORY, "Settings/c.comp.default");

if not os.path.isfile(POCKETNC_ENV_FILE):
    shutil.copyfile([POCKETNC_ENV_FILE, POCKETNC_ENV_DEFAULT_FILE])

if not os.path.isdir(POCKETNC_VAR_DIRECTORY):
    subprocess.call(['sudo', 'mkdir', POCKETNC_VAR_DIRECTORY])

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
