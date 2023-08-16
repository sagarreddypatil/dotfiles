#!/usr/bin/env python3

import psutil
import json

running = any(["wlsunset" in proc.name() for proc in psutil.process_iter()])

if running:
    print(
        json.dumps(
            {
                "text": "NIGHT",
                "class": "night",
                "tooltip": "wlsunset is running",
            }
        )
    )
else:
    print(
        json.dumps(
            {
                "text": "NIGHT",
                "class": "day",
                "tooltip": "wlsunset is not running",
            }
        )
    )
