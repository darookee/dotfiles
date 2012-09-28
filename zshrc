#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('rm * -rf' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('git rm *' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('git *' 'fg=yellow')
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path]='underline'

export PATH=$HOME/.bin.untracked:$HOME/.bin:$PATH
