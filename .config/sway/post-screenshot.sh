#!/bin/sh

to_clip() {
    cat /tmp/screen.png | wl-copy
}

ocr_notify() {
    tesseract /tmp/screen.png - > /tmp/screen.txt 2> /dev/null
    if [ -s /tmp/screen.txt ]; then
        ret_val=$(notify-send --action "default=default" "Screenshot Text" "$(cat /tmp/screen.txt)" -t 5000 --wait)
        if [ "$ret_val" = "default" ]; then
            cat /tmp/screen.txt | wl-copy
        fi
    fi
}

to_clip &
ocr_notify &

wait


