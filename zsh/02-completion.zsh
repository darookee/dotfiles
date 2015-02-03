#
# Authors:
#   Nils Uliczka <nils.uliczka@darookee.net>
#

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
# Completions {{{
# Symfony2 basic command completion {{{
_symfony_console () {
  echo "php $(find . -maxdepth 2 -mindepth 1 -name 'console' -type f | head -n 1)"
}
_symfony2_get_command_list () {
    `_symfony_console` --no-ansi|sed "1,/Available commands/d"|grep :|(while read -r line; do echo $line; done;)|awk '{ gsub(/:/,"\\:",$1); sub(/[  ]/,":", $0); gsub(/[  ]/,"\\ ", $0); print $0; }'
}
_symfony2 () {
   sf2commands=("${(@f)$(_symfony2_get_command_list)}")
   _describe -t sf2commands 'Available commands' sf2commands
}
compdef _symfony2 '`_symfony_console`'
compdef _symfony2 'app/console'
compdef _symfony2 'bin/console'
compdef _symfony2 sf
#Alias
alias sf='`_symfony_console`'
alias sfcl='sf cache:clear'
alias sfcw='sf cache:warmup'
alias sfroute='sf router:debug'
alias sfcontainer='sf container:debug'
alias sfgb='sf generate:bundle'
# }}}
# archive {{{
_archive() {
    _arguments \
        "*::folder:_files -/"
}

compdef _archive archive
# }}}
# ark {{{
_ark() {
    actions=(
        'l:list archive contents'
        'x:extract achive'
        'c:create archive'
    )

    if (( CURRENT == 2 )); then
        _describe -t actions 'actions' actions
    elif (( CURRENT == 3 )); then
        case $words[2] in
            l|x)
                _arguments \
                    "*::archive file:_files -g '(#i)*.(tar|bz2|gz|rar|tbz2|tgz|zip|Z|7z)(-.)'"
                ;;
            c)
                _arguments \
                    "*::files and directories:_files"
                ;;
        esac
    elif (( CURRENT == 4 )); then
        case $words[2] in
            c)
                _arguments \
                    "*::archive file:_files -g '(#i)*.(tar|bz2|gz|rar|tbz2|tgz|zip|Z|7z)(-.)'"
                ;;
        esac
    fi
}
compdef _ark ark


# }}}
# }}}

# vim:fdm=marker ft=zsh
