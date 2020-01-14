#!/bin/bash

monitor=${1:-0}

herbstclient pad $monitor 5 5 30 5

polybar -r bottom
