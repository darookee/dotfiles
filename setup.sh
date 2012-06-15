#!/bin/sh
git submodule update --init --recursive

# Thanks to Kechol (https://gist.github.com/Kechol) for this gist (https://gist.github.com/1862504)

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
    BACKUPDIR="${PWD}/${PREFIX}dotfiles-bak/${BACKUPTIME}"

    if [ ! -d ${BACKUPDIR} ]
    then
        mkdir -p ${BACKUPDIR}
    fi

    if [ -f ${SYMLINK} ]
    then
        mv -f ${SYMLINK} ${BACKUPDIR}
    fi

    echo "${PWD}/${DOTFILE} => ${SYMLINK}"
    ln -fs ${PWD}/${DOTFILE} ${SYMLINK}
done

vim +BundleInstall +qa\!
