#!/bin/bash

printf "#%03x%03x" $((RANDOM%4096)) $((RANDOM%256))
