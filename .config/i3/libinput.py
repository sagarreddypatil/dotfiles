#!/usr/bin/env python3

"""
xinput --set-prop "Elan Touchpad" "libinput Tapping Enabled" 1
xinput --set-prop "Elan Touchpad" "libinput Natural Scrolling Enabled" 1
"""

import os

def strval(val):
    return f'"{val}"'

def xinput_cmd(device, option, value):
    if type(value) is list:
        value = ", ".join([str(val) for val in value])

    os.system(f'xinput --set-prop "{device}" "libinput {option}" {value}')

touchpad = "Elan Touchpad"

xinput_cmd(touchpad, "Tapping Enabled", 1)
xinput_cmd(touchpad, "Natural Scrolling Enabled", 1)
xinput_cmd(touchpad, "Click Method Enabled", [0, 1])
xinput_cmd(touchpad, "Scrolling Pixel Distance", 50)