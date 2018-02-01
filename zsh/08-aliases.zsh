#
# Authors:
#   Nils Uliczka <nils.uliczka@darookee.net>
# Directories {{{
alias ..='cd ..'
alias ls='ls --color=auto --time-style=long-iso'
alias la='ls --color=auto --time-style=long-iso -lah'
alias ll='ls --time-style=long-iso -lh'
alias mkdir='mkdir -pv'

# }}}
# Grep {{{
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
# }}}
# Files over network {{{
if (( $+commands[curl]  )); then
    alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget]  )); then
    alias get='wget --continue --progress=bar --timestamping'
fi

if (( $+commands[python] )); then
    alias http-serve='python -m SimpleHTTPServer'
fi
# rsync {{{
if (( $+commands[rsync] )); then
    _rsync_cmd='rsync --verbose --progress --human-readable --compress --archive --hard-links --one-file-system'


    alias rsync-copy="${_rsync_cmd}"
    alias rsync-move="${_rsync_cmd} --remove-source-files"
    alias rsync-update="${_rsync_cmd} --update"
    alias rsync-synchronize="${_rsync_cmd} --update --delete"

    unset _rsync_cmd
fi
# }}}
# }}}
# git {{{
if (( $+commands[git] )); then

    # Log
    _git_log_medium_format='%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'
    _git_log_oneline_format='%C(green)%h%C(reset) %s%C(red)%d%C(reset)%n'
    _git_log_brief_format='%C(green)%h%C(reset) %s%n%C(blue)(%ar by %an)%C(red)%d%C(reset)%n'
    _git_log_nice_format='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'

    # Status
    _git_status_ignore_submodules='none'

    #
    # Aliases
    #

    # Commit (c)
    alias gc='git commit --verbose'
    alias gcm='git commit --message'
    alias gco='git checkout'
    alias gcO='git checkout --patch'

    # Fetch (f)
    alias gf='git fetch'
    alias gfm='git pull'
    alias gfr='git pull --rebase'

    # Index (i)
    alias gia='git add'
    alias giA='git add --patch'

    # Log (l)
    alias gl='git log --topo-order --pretty=format:${_git_log_medium_format}'
    alias gls='git log --topo-order --stat --pretty=format:${_git_log_medium_format}'
    alias gld='git log --topo-order --stat --patch --full-diff --pretty=format:${_git_log_medium_format}'
    alias glo='git log --topo-order --pretty=format:${_git_log_oneline_format}'
    alias glg='git log --topo-order --all --graph --pretty=format:${_git_log_oneline_format}'
    alias glb='git log --topo-order --pretty=format:${_git_log_brief_format}'
    alias glc='git shortlog --summary --numbered'
    alias gll='git log --graph --abbrev-commit --date=relative --all --pretty=format:${_git_log_nice_format}'

    # Merge (m)
    alias gm='git merge'

    # Push (p)
    alias gp='git push'
    alias gpf='git push --force'
    alias gpa='git push --all'
    alias gpA='git push --all && git push --tags'
    alias gpt='git push --tags'
    alias gpc='git push --set-upstream origin "$(git-branch-current 2> /dev/null)"'
    alias gpp='git pull origin "$(git-branch-current 2> /dev/null)" && git push origin "$(git-branch-current 2> /dev/null)"'

    # Remote (R)
    alias gR='git remote'

    # Stash (s)
    alias gs='git stash'

    # status and diff
    alias gws='git status --ignore-submodules=${_git_status_ignore_submodules} --short'
    alias gwS='git status --ignore-submodules=${_git_status_ignore_submodules}'
    alias gwd='git diff --no-ext-diff'
    alias gwD='git diff --no-ext-diff --word-diff'
fi

# }}}
# Resources {{{
alias df='df -kh'
alias du='du -kh'

if (( $+commands[htop] )); then # use htop when available
    alias top=htop
else
    alias topc='top -o cpu'
    alias topm='top -o vsize'
fi
# }}}
# Shell specific {{{
alias histroy='fc -fl 1'
# }}}
# misc {{{
alias xkcdpw="shuf -n4 /usr/share/dict/words | sed \"s/'s$//\" | tr '[:upper:]' '[:lower:]'|paste -s -d ' '"
if (( $+commands[neomutt] )); then
    alias mutt=neomutt
fi
# }}}


# vim:ft=zsh:fdm=marker
