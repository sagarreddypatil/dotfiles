#!/bin/bash

killall -q polybar

# if type "xrandr"; then
#   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#     MONITOR=$m polybar --reload mybar &
#   done
# else
#   polybar --reload mybar &
# fi

polybar --reload mybar &

# polybar mybar 2>&1 | tee -a /tmp/polybar.log & disown

