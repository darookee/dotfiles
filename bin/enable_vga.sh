#!/bin/bash

xrandr --output LVDS-1 --auto --primary --output VGA-1 --auto --below LVDS-1
bspc monitor VGA-1 -d 6 7 8 9

touch $HOME/.has_output
