#!/bin/sh
# Thanks to Kechol (https://gist.github.com/Kechol) for this gist (https://gist.github.com/1862504)

cd "$( dirname "${BASH_SOURCE[0]}" )"

#symlinks
PWD=`pwd`
PREFIX='.'
DOTFILES=${PWD}/*
IGNOREFILES=( setup.sh README.md )

# Cleanup old installations

# remove antigen
if [ -e "${HOME}/.antigen" ]; then
    rm -rf ${HOME}/.antigen
fi

# remove zgen
if [ -e "${HOME}/.zgen" ]; then
    rm -rf ${HOME}/.zgen
fi

# remove vim-plug
if [ -e "${HOME}/.vim/autoload/plug.vim" ]; then
    rm -f ${HOME}/.vim/autoload/plug.vim
fi

for DOTFILE in ${PWD}/*; do
    for IGNOREFILE in ${IGNOREFILES[@]}; do
        if [ ${DOTFILE} == ${IGNOREFILE} ]; then
            continue 2
        fi
    done

    SYMLINK="${HOME}/${PREFIX}${DOTFILE}"

    if [ -e ${SYMLINK} ]; then
        rm -f ${SYMLINK}
    fi

    echo "${PWD}/${DOTFILE} => ${SYMLINK}"
    ln -sf ${PWD}/${DOTFILE} ${SYMLINK}

    if [ -e "${PWD}/${DOTFILE}.local" ]; then
        echo "Adding local settings from ${PWD}/${DOTFILE}.local => ${SYMLINK}"
        cat ${PWD}/${DOTFILE}.local >> ${SYMLINK}
    fi
done
