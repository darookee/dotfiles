#!/bin/sh
git submodule update --init --recursive

for rcfile in `ls -1 .`; do
    ln -s -f ~/.dotfiles/$rcfile ~/.$rcfile
done
