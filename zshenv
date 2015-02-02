# Treat top-level shells as "login" shells.
if [[ $SHLVL == 1 && ! -o LOGIN ]]; then
    source "${ZDOTDIR:-$HOME}/.zprofile"
fi
# include zshenv.local {{{
[[ -e ${HOME}/.zshenv.local ]] && source ${HOME}/.zshenv.local
# }}}

# vim:fdm=marker ft=zsh
