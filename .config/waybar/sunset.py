#!/usr/bin/env -S uv run --script
# /// script
# dependencies = [
#   "psutil",
#   "requests",
# ]
# ///

import requests
import os
import sys
import psutil

loc_cache = os.path.join(os.environ["HOME"], ".cache", "sunset-loc")
os.makedirs(os.path.dirname(loc_cache), exist_ok=True)

def save_location(lat, lng):
    with open(loc_cache, "w") as f:
        f.write(f"{lat},{lng}")

def load_location():
    if not os.path.exists(loc_cache):
        return None

    with open(loc_cache, "r") as f:
        return f.read().split(",")


if any(["wlsunset" in proc.name() for proc in psutil.process_iter()]):
    os.system("killall wlsunset")
    sys.exit()


def location():
    try:
        ip = requests.get("https://ipinfo.io/ip", timeout=0.1).text
        resp = requests.get(f"https://ipinfo.io/widget/demo/{ip}", timeout=0.1).json()

        lat, lng = resp["data"]["loc"].split(",")
    except Exception as e:
        print(e)

        ret = load_location()
        if not ret:
            print("Failed to get location")
            sys.exit()

        lat, lng = ret

    save_location(lat, lng)
    return lat, lng


lat, lng = location()

# run wlsunset
os.system(f"wlsunset -l {lat} -L {lng} -t 3000 &")
