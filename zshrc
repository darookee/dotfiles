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
gpg-agent
composer
systemadmin
sudo

zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
zsh-users/zsh-completions src
zsh-users/zaw

darookee/minimo
darookee/zsh-functions
EOBUNDLES

# bind UP and DOWN arrow keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=white'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red'

# zaw styles
zstyle ':filter-select:highlight' matched fg=green
zstyle ':filter-select' max-lines 5
zstyle ':filter-select' case-insensitive yes # enable case-insensitive 
zstyle ':filter-select' extended-search yes # see below

# Customize to your needs...
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('rm * -rf' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('git rm *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('git *' 'fg=yellow')
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path]='underline'

autoload -Uz promptinit ; promptinit
prompt minimo

antigen apply

[ -e "${ZDOTDIR:-$HOME}/.zsh/options.zsh" ] && source "${ZDOTDIR:-$HOME}/.zsh/options.zsh"
[ -e "${ZDOTDIR:-$HOME}/.zsh/aliases.zsh" ] && source "${ZDOTDIR:-$HOME}/.zsh/aliases.zsh"


PATH=$HOME/.bin.untracked:$HOME/.bin:$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# vim:fdm=marker
