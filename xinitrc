#!/bin/sh

setxkbmap -layout de -variant nodeadkeys

[[ -f ~/.Xresources  ]] && xrdb ~/.Xresources

# restore_volume

xset b off
xsetroot -cursor_name left_ptr
hsetroot -solid \#a6826d

sxhkd &
bspwm &
# compton -cb &
unclutter -grab &
# xautolock -time 5 -locker ~/.bin.untracked/locker &
~/.config/bspwm/panel 2>/dev/null
