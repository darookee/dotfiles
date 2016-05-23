#!/bin/bash

if [[ ! -e "$HOME/.has_output" ]]; then
    enable_vga.sh
else
    disable_vga.sh
fi
