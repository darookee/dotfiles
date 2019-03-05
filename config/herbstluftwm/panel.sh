#!/bin/bash

monitor=${1:-0}

herbstclient pad $monitor 35 5 5 5

polybar -r example
