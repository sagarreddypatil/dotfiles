#!/usr/bin/env python3

import json
import requests
import os
import sys
import psutil

if any(["wlsunset" in proc.name() for proc in psutil.process_iter()]):
    os.system("killall wlsunset")
    sys.exit()

# wait until internet
import time

while True:
    try:
        requests.get("http://google.com")
        break
    except:
        time.sleep(1)

# get location
location = requests.get(
    "https://location.services.mozilla.com/v1/geolocate?key=geoclue"
).json()

lat = location["location"]["lat"]
lng = location["location"]["lng"]

# run wlsunset
os.system(f"wlsunset -l {lat} -L {lng} -t 3000 &")
