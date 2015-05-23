#!/bin/bash

echo -n "#"
perl -e'print[0..9,A..F]->[rand 16]for 1..8'
