# Treat top-level shells as "login" shells.
if [[ $SHLVL == 1 && ! -o LOGIN ]]; then
    source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# vim:fdm=marker ft=zsh
