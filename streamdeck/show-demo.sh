#!/usr/bin/env bash

echo "Show Demo"

WINDOW_CLASS=firefox

# get window id from class name
WINDOW_ID=$(wmctrl -l -x | grep $WINDOW_CLASS | cut -d ' ' -f 1)

# show window at front
#wmctrl -i -r $WINDOW_ID -b toggle,above
# activate the window
wmctrl -i -a $WINDOW_ID

# send d keycode
xdotool type 'd'
