#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
