#!/bin/bash

xrandr --output LVDS-1 --auto --primary --output VGA-1 --off
bspc monitor -r 6 7 8 9

rm $HOME/.has_output &> /dev/null
