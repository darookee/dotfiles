#!/bin/bash
# Thanks to Kechol (https://gist.github.com/Kechol) for this gist (https://gist.github.com/1862504)
 
cd "$( dirname "${BASH_SOURCE[0]}" )" || exit

#symlinks
update=${1:-no}
PWD=$(pwd)
prefix='.'
dotfiles=$(git ls-files)
ignorefiles=( setup.sh README.md .gitignore )

# Cleanup old installations

# remove antigen
if [[ -e "${HOME}/.antigen" && "$update" == "no" ]]; then
    rm -rf "${HOME}/.antigen"
fi

# remove zgen
if [[ -e "${HOME}/.zgen" && "$update" == "no" ]]; then
    rm -rf "${HOME}/.zgen"
fi

# remove vim-plug
if [[ -e "${HOME}/.vim/autoload/plug.vim" && "$update" == "no" ]]; then
    rm -f "${HOME}/.vim/autoload/plug.vim"
fi

for dotfile in ${dotfiles}; do
    dotfiledir=$(dirname "${dotfile}")

    for ignorefile in "${ignorefiles[@]}"; do
        if [[ "${dotfile}" == "${ignorefile}" ]]; then
            continue 2
        fi
    done

    symlink="${HOME}/${prefix}${dotfile}"
    symlinkdir="${HOME}/${prefix}${dotfiledir}"

    if [ -e "${symlink}" ]; then
        rm -f "${symlink}"
    fi

    echo "${PWD}/${dotfile} => ${symlink}"
    [[ -d "${symlinkdir}" ]] || mkdir -p "${symlinkdir}"
    ln -sf "${PWD}/${dotfile}" "${symlink}"

    if [[ -e "${PWD}/${dotfile}.local" && "${update}" == no ]]; then
        echo "Adding local settings from ${PWD}/${dotfile}.local => ${symlink}"
        cat "${PWD}/${dotfile}.local" >> "${symlink}"
    fi
done

if command -v php 2>/dev/null; then
    if [[ ! -f "${HOME}/.bin/composer" ]]; then
        command -v curl 2>/dev/null && curl -Ls -o "${HOME}/.bin/composer" \
        https://getcomposer.org/composer.phar && chmod +x "${HOME}/.bin/composer"
    fi
    composer global install
fi
