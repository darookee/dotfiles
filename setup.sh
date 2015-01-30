#!/bin/sh
# Thanks to Kechol (https://gist.github.com/Kechol) for this gist (https://gist.github.com/1862504)

cd "$( dirname "${BASH_SOURCE[0]}" )"

#symlinks
PWD=`pwd`
PREFIX='.'
DOTFILES=$(git ls-files)
IGNOREFILES=( setup.sh README.md .gitignore )

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

for DOTFILE in ${DOTFILES}; do
    DOTFILEDIR=$(dirname ${DOTFILE})

    for IGNOREFILE in ${IGNOREFILES[@]}; do
        if [ ${DOTFILE} == ${IGNOREFILE} ]; then
            continue 2
        fi
    done

    SYMLINK="${HOME}/${PREFIX}${DOTFILE}"
    SYMLINKDIR="${HOME}/${PREFIX}${DOTFILEDIR}"

    if [ -e ${SYMLINK} ]; then
        rm -f ${SYMLINK}
    fi

    echo "${PWD}/${DOTFILE} => ${SYMLINK}"
    [[ -d ${SYMLINKDIR} ]] || mkdir -p ${SYMLINKDIR}
    ln -sf ${PWD}/${DOTFILE} ${SYMLINK}

    if [ -e "${PWD}/${DOTFILE}.local" ]; then
        echo "Adding local settings from ${PWD}/${DOTFILE}.local => ${SYMLINK}"
        cat ${PWD}/${DOTFILE}.local >> ${SYMLINK}
    fi
done
