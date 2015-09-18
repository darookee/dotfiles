#!/bin/sh

setxkbmap -layout de -variant nodeadkeys

[[ -f ~/.Xresources  ]] && xrdb ~/.Xresources

restore_volume

xset b off
xsetroot -cursor_name left_ptr
hsetroot -solid "$(random_hex_color.sh)"

sxhkd &
bspwm &
compton -cb &
unclutter --timeout 1 -b
xautolock -time 5 -locker ~/.bin/locker &
xflux -l 52.4 -g 10.5 -r 1 -nofork &
~/.config/bspwm/panel 2>/dev/null &
~/.bin/xwait
