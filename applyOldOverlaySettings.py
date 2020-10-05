#!/usr/bin/python3

import sys
import os
import subprocess
import re
import pprint

POCKETNC_DIRECTORY = "/home/pocketnc/pocketnc"

sys.path.insert(0, os.path.join(POCKETNC_DIRECTORY, "Rockhopper"));
from ini import read_ini_data, merge_ini_data, write_ini_data, ini_differences, remove_ini_data

CALIBRATION_OVERLAY_FILE = os.path.join(POCKETNC_DIRECTORY, "Settings/CalibrationOverlay.inc")
OLD_OVERLAY_FILE = os.path.join(POCKETNC_DIRECTORY, "OverlaySettings2.0.1-beta-7AndOlder.inc")
DEFAULT_FILE = os.path.join(POCKETNC_DIRECTORY, "Settings/PocketNC.ini.default")

# The CalibrationOverlay.inc file is supposed to store only the settings that are specific to 
# an individual machine's calibration.
# In v2.0.1-beta-7 and before the CalibrationOverlay.inc file contained important machine settings
# not specific to a machine. All later versions have those settings in PocketNC.ini.default. 
# The calibration overlay file only stores differences between PocketNC.ini.default and the current
# settings, so in newer versions the settings are removed from the overlay file. Since the calibration
# overlay is supposed to be machine specific and is not version controlled, those settings are needed
# when reverting to an old version. This script is run in preUpdate.sh in versions 
# after v2.0.1-beta-7 and detects what version we're switching to. If we're switching to version 
# v2.0.1-beta-7 or before, merge the settings in OverlaySettings2.0.1-beta-7AndOlder.inc with CalibrationOverlay.inc.
# If we're switching to a later version, remove those settings from the overlay.


# modified from https://stackoverflow.com/questions/5967500/how-to-correctly-sort-a-string-with-a-number-inside
def toIntOrString(text):
    try:
        retval = int(text)
    except ValueError:
        retval = text
    return retval

def natural_keys(text):
    return [ toIntOrString(c) for c in re.split('[v.-]', text) ]

v = sys.argv[1]

calibration = read_ini_data(CALIBRATION_OVERLAY_FILE)
old = read_ini_data(OLD_OVERLAY_FILE)

if natural_keys(v) <= natural_keys("v2.0.1-beta-7"):
# if we're changing to a version less than or equal to v2.0.1-beta-7
# then add in the old settings to the overlay
    merged = merge_ini_data(calibration, old) 

    write_ini_data(merged, CALIBRATION_OVERLAY_FILE)
else:
# otherwise, remove the old settings from the overlay
    trimmed = remove_ini_data(calibration, [ { 'name': p['values']['name'], 'section': p['values']['section'] } for p in old['parameters'] ])

    write_ini_data(trimmed, CALIBRATION_OVERLAY_FILE)
