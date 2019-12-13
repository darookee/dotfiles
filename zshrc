# variables {{{
export XDG_CACHE_HOME=${XDG_CACHE_HOME:=~/.cache}
export ZSH_HOME=${XDG_CACHE_HOME}/zsh

# history
HISTFILE=${ZSH_HOME}/zhistory
HISTSIZE=10000
SAVEHIST=10000
HIST_STAMPS="yyyy-mm-dd"

# stacks
DIRSTACKSIZE=20

typeset -A ZPLGM
ZPLG_HOME=${ZSH_HOME}/zplugin
ZPLGM[HOME_DIR]=$ZPLG_HOME
ZPLGM[ZCOMPDUMP_PATH]=${ZSH_HOME}/zcompdump
# }}}
# zplugin {{{
if [[ ! -f $ZPLG_HOME/bin/zplugin.zsh ]]; then
    git clone https://github.com/psprint/zplugin $ZPLG_HOME/bin
    zcompile $ZPLG_HOME/bin/zplugin.zsh
fi

source $ZPLG_HOME/bin/zplugin.zsh
# }}}
# plugins {{{
zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-history-substring-search
zplugin light zdharma/fast-syntax-highlighting
zplugin light zdharma/history-search-multi-word

zplugin ice pick'async.zsh' src'pure.zsh'
zplugin light sindresorhus/pure

zplugin ice as"completion"
zplugin snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zplugin cdclear -q
# }}}
# keys {{{
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
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       history-substring-search-up
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     history-substring-search-down
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
# }}}
# keybindings {{{
# edit command with C-xC-e
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
bindkey -M viins '\C-x\C-e' edit-command-line

# Add sudo with C-xs
sudo-command-line() {
[[ -z $BUFFER  ]] && zle up-history
[[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
zle end-of-line
}
zle -N sudo-command-line
bindkey "\C-xs" sudo-command-line

bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
# }}}
# options {{{
# basic
setopt no_beep

# directories
setopt auto_cd
setopt auto_pushd
setopt cdablevars
setopt pushd_ignore_dups
setopt chaselinks
setopt pushd_to_home
setopt pushd_silent
setopt pushd_ignore_dups
setopt pushd_minus
setopt pathdirs

# globbing
setopt extended_glob
setopt nocaseglob

# completion
setopt always_to_end
setopt auto_menu
setopt auto_name_dirs
setopt complete_in_word
setopt auto_param_slash
setopt no_complete_aliases
setopt list_ambiguous

# history
setopt hash_list_all
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt banghist

# misc
setopt no_sh_word_split
setopt no_no_match
setopt prompt_subst
unsetopt correct_all
setopt correct
setopt no_clobber
setopt no_rm_star_silent

# }}}
# aliases {{{

# directories
alias ..='cd ..'
alias ls='ls --color=auto --time-style=long-iso'
alias la='ls --color=auto --time-style=long-iso -lah'
alias ll='ls --time-style=long-iso -lh'
alias mkdir='mkdir -pv'

# grep
grep-flag-available(){
echo | grep $1 "" >/dev/null 2>&1
}

GREP_OPTIONS="--color=auto"
VCD_FOLDERS="{.bzr,.vcs,.git,.hg,.svn}"

if grep-flag-available --exclude-dir=.vcs; then
    GREP_OPTIONS+=" --exclude-dir=$VCS_FOLDERS"
elif grep-flag-available --exclude=.vcs; then
    GREP_OPTIONS+=" --exclude=$VCS_FOLDERS"
fi

alias grep="grep $GREP_OPTIONS"

unset GREP_OPTIONS
unset VCS_FOLDERS
unfunction grep-flag-available

# download files
if (( $+commands[curl]  )); then
    alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget]  )); then
    alias get='wget --continue --progress=bar --timestamping'
fi

# rsync
if (( $+commands[rsync] )); then
    _rsync_cmd='rsync --verbose --progress --human-readable --compress --archive --hard-links --one-file-system'

    alias rsync-copy="${_rsync_cmd}"
    alias rsync-move="${_rsync_cmd} --remove-source-files"
    alias rsync-update="${_rsync_cmd} --update"
    alias rsync-synchronize="${_rsync_cmd} --update --delete"

    unset _rsync_cmd
fi

# git
if (( $+commands[git] )); then

    # Log
    _git_log_medium_format='%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'
    _git_log_oneline_format='%C(green)%h%C(reset) %s%C(red)%d%C(reset)%n'
    _git_log_brief_format='%C(green)%h%C(reset) %s%n%C(blue)(%ar by %an)%C(red)%d%C(reset)%n'
    _git_log_nice_format='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'

    # Status
    _git_status_ignore_submodules='none'

    # commit
    alias gc='git commit --verbose'

    # pull/fetch
    alias gf='git fetch'
    alias gfm='git pull'

    # add
    alias gia='git add'
    alias giA='git add --patch'

    # log
    alias gl='git log --topo-order --pretty=format:${_git_log_medium_format}'
    alias gls='git log --topo-order --stat --pretty=format:${_git_log_medium_format}'
    alias gld='git log --topo-order --stat --patch --full-diff --pretty=format:${_git_log_medium_format}'
    alias glo='git log --topo-order --pretty=format:${_git_log_oneline_format}'
    alias glg='git log --topo-order --all --graph --pretty=format:${_git_log_oneline_format}'
    alias glb='git log --topo-order --pretty=format:${_git_log_brief_format}'
    alias glc='git shortlog --summary --numbered'
    alias gll='git log --graph --abbrev-commit --date=relative --all --pretty=format:${_git_log_nice_format}'

    # push
    alias gp='git push'

    # remote
    alias gR='git remote'

    # status and diff
    alias gws='git status --ignore-submodules=${_git_status_ignore_submodules} --short'
    alias gwS='git status --ignore-submodules=${_git_status_ignore_submodules}'
    alias gwd='git diff --no-ext-diff'
    alias gwD='git diff --no-ext-diff --word-diff'
fi

# use human readable filesizes
alias df='df -kh'
alias du='du -kh'

# use smart case for alternative greps
if (( $+commands[rg] )); then
    alias rg="rg -S"
fi

if (( $+commands[sift] )); then
    alias sift="sift -S"
fi

if (( $+commands[ag] )); then
    alias ag="ag -S"
fi

# substitute some commands with modern versions
if (( $+commands[htop] )); then # use htop when available
    alias top=htop
fi

if (( $+commands[neomutt] )); then # use neomutt instead of mutt
    alias mutt=neomutt
fi

if (( $+commands[exa] )); then # use exa instead of ls
    alias ls="exa"
    alias la="exa -la"
    alias ll="exa -l"
fi

if (( $+commands[nvim] )); then
    alias vi="nvim"
    alias vim="nvim"
fi

# }}}
# functions {{{
# ark - wrapper for multiple archiving tools
ark () {
    case $1 in
        l)
            case $2 in
                *.tar.bz2)   tar tvjf $2      ;;
                *.tar.gz)    tar tvzf $2      ;;
                *.rar)       unrar l $2       ;;
                *.tar)       tar tvf $2       ;;
                *.tbz2)      tar tvjf $2      ;;
                *.tgz)       tar tvzf $2      ;;
                *.zip)       unzip -l $2      ;;
                *.7z)        7z l $2          ;;
                *)           echo "Cannot list contents of '$2' with >ark<" ;;
            esac ;;

        x)
            case $2 in
                *.tar.bz2)   tar xvjf $2      ;;
                *.tar.gz)    tar xvzf $2      ;;
                *.bz2)       bunzip2 $2       ;;
                *.rar)       unrar x $2       ;;
                *.gz)        gunzip $2        ;;
                *.tar)       tar xvf $2       ;;
                *.tbz2)      tar xvjf $2      ;;
                *.tgz)       tar xvzf $2      ;;
                *.zip)       unzip $2         ;;
                *.Z)         uncompress $2    ;;
                *.7z)        7z x $2          ;;
                *)           echo "Cannot unpack '$2' with >ark<" ;;
            esac ;;

        c)
            case $2 in
                *.tar.*)    arch=$2; shift 2;
                    tar cvf ${arch%.*} $@
                    case $arch in
                        *.gz)   gzip -9r ${arch%.*}   ;;
                        *.bz2)  bzip2 -9zv ${arch%.*} ;;
                    esac                              ;;
                *.rar)      shift; rar a -m5 -r $@; rar k $1    ;;
                *.zip)      shift; zip -9r $@                   ;;
                *.7z)       shift; 7z a -mx9 $@                 ;;
                *)          echo "Unsupported archive type"     ;;
            esac ;;

        *)
            echo "(l)ist e(x)tract or (c)reate" ;;
    esac
}

# completion for ark
_ark () {
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
# }}}
# init {{{
autoload -U compinit
compinit -d ${ZSH_HOME}/zcompdump-${ZSH_VERSION}
# }}}
# prompt {{{
_rprompt () {
    print -n "%F{242}%D{%F} %F{white}%D{%H:%M}%f"
}

RPROMPT='$(_rprompt)'
# }}}
#
# vim:fdm=marker ft=zsh
