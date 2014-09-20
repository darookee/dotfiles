#!/bin/sh
# Thanks to Kechol (https://gist.github.com/Kechol) for this gist (https://gist.github.com/1862504)

cd "$( dirname "${BASH_SOURCE[0]}" )"

git clone https://github.com/darookee/dotfiles-bin.git ${PWD}/.bin
${PWD}/.bin/setup.sh
ln -sf ${PWD}/.bin/bin/ ${PWD}/bin

#symlinks
PWD=`pwd`
PREFIX='.'
DOTFILES=`ls -1`
IGNOREFILES=( .. bak setup.sh README.md .git )

#cleanup
if [ -e "${HOME}/.antigen" ]; then
    rm -rf ${HOME}/.antigen
fi

if [ -e "${HOME}/.vim/autoload/plug.vim" ]; then
    rm -f ${HOME}/.vim/autoload/plug.vim
fi

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

    if [ -e ${SYMLINK} ]
    then
        rm -f ${SYMLINK}
    fi

    echo "${PWD}/${DOTFILE} => ${SYMLINK}"
    ln -fs ${PWD}/${DOTFILE} ${SYMLINK}

    if [ -e "${PWD}/${DOTFILE}.local" ]; then
        cat ${PWD}/${DOTFILE}.local >> ${PWD}/${DOTFILE}
    fi
done
