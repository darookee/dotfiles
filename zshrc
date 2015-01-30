#
# Authors:
#   Nils Uliczka <nils.uliczka@darookee.net>
#

# Load zgen {{{
#
[ -d "${ZDOTDIR:-$HOME}/.zgen" ] || mkdir ${ZDOTDIR:-$HOME}/.zgen

if [[ ! -s "${ZDOTDIR:-$HOME}/.zgen/zgen.zsh" ]]; then
    curl -fLo ${ZDOTDIR:-$HOME}/.zgen/zgen.zsh https://raw.githubusercontent.com/tarjoilija/zgen/master/zgen.zsh
    chmod +x ${ZDOTDIR:-$HOME}/.zgen/zgen.zsh
fi

source "${ZDOTDIR:-$HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
    zgen load zsh-users/zsh-history-substring-search
    zgen load darookee/pure
    zgen load zsh-users/zsh-syntax-highlighting
    zgen save
fi

# }}}
# Load modules {{{
#
autoload -U compinit promptinit colors edit-command-line
# colors {{{
colors
# }}}
# }}}
# Options {{{
#
setopt autolist               # list choices on ambiguous completion
setopt automenu               # show menu on double-tab
setopt autoparamslash         # add slash after directory
setopt hashlistall            # hash everything before completion
setopt alwaystoend            # when completing from the middle of a word, move the cursor to the end of the word
setopt completeinword         # allow completion from within a word/phrase
setopt correct                # spelling correction for commands
setopt listambiguous          # complete as much of a completion until it gets ambiguous.
setopt extendedglob           # use # ~ and ^ for globbing
setopt nocompletealiases      # don't complete alisases
setopt nocaseglob             # case insensitive glob
setopt banghist               # treat ! special
setopt extendedhistory        # save start time and duration to history
setopt incappendhistory       # continious write history insted of waiting for shell exit
setopt sharehistory           # share history between running sessions
setopt histexpiredupsfirst    # purge duplicates first when history needs trimming
setopt histignoredups         # don't save duplicate commands to history
setopt histignorealldups      # remove old duplicate command from history
setopt histfindnodups         # don't use duplicates as results for searching
setopt histsavenodups         # don't save duplicate entries
setopt histignorespace        # don't save to history when command starts with space
setopt histverify             # don't execute line with history expansion, just expand
setopt autoparamkeys          # remove space after completion, when closing brackt is inserted
setopt pathdirs               # perform path search for commands (X11/xinit -> /usr/local/bin/X11/xinit)
setopt autopushd              # push to directory stack
setopt pushdsilent            # don't print stack after pushing
setopt pushdtohome            # `pushd` acts like `cd` -> `pushd $HOME`
setopt pushdignoredups        # Remove duplicate entries
setopt pushdminus             # This reverts the +/- operators.
setopt autocd                 # cd without cd
setopt cdablevars             # cd ínto pathesfrom variables
setopt noclobber              # dont overwrite existing files whn piping
setopt chaselinks             # resolve links when cding
setopt normstarsilent         # ask before rm *
setopt promptsubst            # parameter expansion, command substitution and arithmetic expansion in prompt
# }}}
# Completion {{{
#
compinit

# general {{{
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*' cache-path "${ZDOTDIR:-$HOME}/.zcompcache"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' menu select=2
zstyle ':completion:*::::' completer _expand _complete _match _ignored _approximate
zstyle '*' single-ignored show
# }}}
# messages and groups {{{
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:manuals' separate-sections true
# }}}
# _approximate {{{
zstyle ':completion:*:approximate:*' max-errors 1 numeric
# Increase the number of errors based on the length of the typed word.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
# }}}
# directories {{{
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' special-dirs true
# }}}
# hostnames {{{
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${=${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
  ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'
# }}}
# kill and rm {{{
# Ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single
# }}}
# ssh and rsync {{{
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
# }}}

# }}}
# History {{{
#
HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
HISTSIZE=10000
SAVEHIST=10000
HIST_STAMPS="yyyy-mm-dd"
# }}}
# Keybindings {{{
#
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}
key[ShiftTab]=${terminfo[kcbt]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history
[[ -n "${key[ShiftTab]}" ]]  && bindkey  "${key[ShiftTab]}" reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# Additional keybindings
bindkey 'jj' vi-cmd-mode # exit insert mode
bindkey -M viins 'jj' vi-cmd-mode # exit insert mode
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
bindkey -M viins '\C-x\C-e' edit-command-line
# }}}
# Directories {{{

DIRSTACKSIZE=20
# }}}
# Aliases {{{
[[ -f "${HOME}/.aliases" ]] && source ${HOME}/.aliases
# }}}
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
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
# }}}
# }}}
# includes (rvm,...) {{{
#
# include rvm if exists
#
if [[ -d "${HOME}/.rvm" ]]; then
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi
# }}}
# Prompt {{{
#
promptinit

if [[ "$TERM" == "linux" ]]; then
    prompt redhat

    # add git info to readhat RPROMPT
    autoload -Uz vcs_info 
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:git:*' check-for-changes true
    precmd() {
        vcs_info
        RPROMPT="${vcs_info_msg_0_}"
    }
else
    prompt pure
fi
# }}}

# vim:fdm=marker ft=zsh
