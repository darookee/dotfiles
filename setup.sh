#!/bin/sh
# Thanks to Kechol (https://gist.github.com/Kechol) for this gist (https://gist.github.com/1862504)

cd "$( dirname "${BASH_SOURCE[0]}" )"

if [ ! -d "./antigen" ]; then
    git clone https://github.com/zsh-users/antigen.git ./antigen
fi

git submodule update --init --recursive

#symlinks
PWD=`pwd`
PREFIX='.'
DOTFILES=`ls -1`
IGNOREFILES=( .. bak setup.sh README.md .git )

for DOTFILE in ${DOTFILES[@]}
do
    for IGNOREFILE in ${IGNOREFILES[@]}
    do
        if [ ${DOTFILE} == ${IGNOREFILE} ]
        then
            continue 2
        fi
    done

    SYMLINK="${HOME}/${PREFIX}${DOTFILE}"
    BACKUPTIME=`date +%s`
    BACKUPDIR="${HOME}/${PREFIX}dotfiles-bak/${BACKUPTIME}"

    if [ ! -d ${BACKUPDIR} ]
    then
        mkdir -p ${BACKUPDIR}
    fi

    if [ -e ${SYMLINK} ]
    then
        mv -f ${SYMLINK} ${BACKUPDIR}
    fi

    echo "${PWD}/${DOTFILE} => ${SYMLINK}"
    ln -fs ${PWD}/${DOTFILE} ${SYMLINK}
done

vim +qa\!

chmod +x ${HOME}/.bin/*
