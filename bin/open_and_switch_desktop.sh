#!/bin/bash

case "${1}" in
    1)
        program="st"
        pattern="^st$"
        ;;
    2)
        program="google-chrome-stable --user-data-dir=.config/google-chrome"
        pattern="chrome"
        ;;
    3)
        program="firefox"
        pattern="firefox"
        ;;
    4)
        program="google-chrome-stable --user-data-dir=.config/google-chrome-office"
        pattern="chrome"
        ;;
esac

bspc desktop -f \^${1}
pgrep ${pattern} &> /dev/null || $program &
