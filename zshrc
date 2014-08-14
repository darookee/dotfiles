#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Nils Uliczka <nils.uliczka@darookee.net>
#

# Load Antigen
if [[ -s "${ZDOTDIR:-$HOME}/.antigen/antigen.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.antigen/antigen.zsh"
fi

antigen bundles <<EOBUNDLES
robbyrussell/oh-my-zsh lib/

common-aliases
git
#ssh-agent
#gpg-agent
composer
systemadmin
sudo

zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
zsh-users/zsh-completions src
zsh-users/zaw

darookee/minimo
darookee/zsh-functions

#sorin-ionescu/prezto modules/gpg
EOBUNDLES

autoload -Uz promptinit ; promptinit
prompt minimo

[ -e "${ZDOTDIR:-$HOME}/.zsh/options.zsh" ] && source "${ZDOTDIR:-$HOME}/.zsh/options.zsh"
[ -e "${ZDOTDIR:-$HOME}/.zsh/aliases.zsh" ] && source "${ZDOTDIR:-$HOME}/.zsh/aliases.zsh"

antigen apply

start_ssh-agent
start_gpg-agent

PATH=$HOME/.bin.untracked:$HOME/.bin:$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# vim:fdm=marker
