#!/bin/bash

# For Arch
#
# after installing yaourt this can be run to make the best use of the X-portion
# of the .dotfiles
#

yaourt -S rsync openssh
yaourt -S xorg-server xf86-video-intel xorg-xinit
yaourt -S acpi alsa-utils mpc terminus-font imagemagick powerline-fonts-git
yaourt -S sxhkd bspwm i3lock xautolock hsetroot unclutter st bar-aint-recursive demnu
yaourt -S dillo
