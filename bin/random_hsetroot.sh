#!/bin/bash

export DISPLAY=:0

hsetroot -solid "$($(dirname ${0})/random_hex_color.sh)"
