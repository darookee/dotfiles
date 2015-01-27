#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Nils Uliczka <nils.uliczka@darookee.net>
#

PATH=$HOME/.bin.untracked:$HOME/.bin:$PATH


# Load Antigen
[ -d "${ZDOTDIR:-$HOME}/.antigen" ] || mkdir ${ZDOTDIR:-$HOME}/.antigen

if [[ ! -s "${ZDOTDIR:-$HOME}/.antigen/antigen.zsh" ]]; then
    curl -fLo ${ZDOTDIR:-$HOME}/.antigen/antigen.zsh https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh
    chmod +x ${ZDOTDIR:-$HOME}/.antigen/antigen.zsh
fi

source "${ZDOTDIR:-$HOME}/.antigen/antigen.zsh"

antigen bundles <<EOBUNDLES

zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
zsh-users/zsh-completions src
zsh-users/zaw

darookee/gentoo-zsh-completions
darookee/minair
darookee/zsh-functions
darookee/zsh-settings

EOBUNDLES

if [ -d "$HOME/.rvm" ]; then
    PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
    if [[ -s $HOME/.rvm/scripts/rvm ]]; then
        antigen bundle robbyrussell/oh-my-zsh plugins/rvm
    fi
fi

antigen apply

export GPG_TTY=$( tty )
eval `get_keychain_keys|xargs keychain --eval`

# Set prompt
if [[ "$TERM" == "linux" ]]; then
    prompt redhat
else
    prompt minair
fi

# vim:fdm=marker
