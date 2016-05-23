#!/bin/sh

[[ -f ~/.xmodmap.conf ]] && xmodmap ~/.xmodmap.conf

setxkbmap -layout de -variant nodeadkeys

[[ -f ~/.Xresources  ]] && xrdb ~/.Xresources

xset b off
xsetroot -cursor_name left_ptr
hsetroot -solid "$(random_hex_color.sh)"

compton -cb &
unclutter --timeout 1 -b
xautolock -time 5 -locker ~/.bin/locker &
xflux -l 52.4 -g 10.5 -r 1 -nofork &
st zsh --login -c "~/.bin/tmx X" &
exec bspwm
