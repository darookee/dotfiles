#
# Authors:
#   Nils Uliczka <nils.uliczka@darookee.net>
#

# Plugin-Options {{{
# history-substring-search {{{
#
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=black'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=white,bg=red'
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       history-substring-search-up
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     history-substring-search-down

bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
# }}}
# zsh-syntax-highlighting {{{
#
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS+=(' -rf ' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('sudo ' 'fg=yellow,bold')
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
# }}}
# }}}

# vim:fdm=marker ft=zsh
