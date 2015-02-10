#
# Authors:
#   Nils Uliczka <nils.uliczka@darookee.net>
#

if [[ -z "$LANG" ]]; then
    export LANG='en_US.UTF-8'
fi

# Use 256 color terminal inside tmux
if [[ -n "$TMUX"  ]]; then
    export TERM="screen-256color"
fi
# Set PATH {{{
function path-prepend {
    [[ -d "$1" ]] && path[1,0]=($1)
}
path-prepend "${HOME}/.bin"
path-prepend "${HOME}/.bin.untracked"
path-prepend "${HOME}/.local/bin" # python
# [[ -d "${HOME}/.rvm" ]] && path-prepend "${HOME}/.rvm/bin"
# }}}
# Set CDPATH {{{
function cdpath-append {
    [[ -d "$1" ]] && cdpath+=($1)
}
cdpath-append "${HOME}"
cdpath-append "${HOME}/Dev/Kunden"
# }}}

(( $+commands[vim] )) && editor='vim' || editor='nano'
export EDITOR=$editor
export VISUAL=$editor

export PAGER='less'
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Load dir_colors if file exists
[[ -e "${HOME}/.dir_colors" ]] && (( $+commands[dircolors] ))  && eval `dircolors "${HOME}/.dir_colors"`

# Setup tempdir
if [[ "${TMPDIR}" == "" ]]; then
    export TMPDIR="/tmp/$USER"
fi

if [[ ! -d "$TMPDIR" ]]; then
    mkdir -p -m 700 "$TMPDIR"
fi

export TMPPREFIX="${TMPDIR}/zsh"
if [[ -d "$TMPPREFIX" ]]; then
    mkdir -p -m 700 "$TMPPREFIX"
fi

# colors {{{
typeset -Ag FX FG BG

FX=(
    reset     "%{^[[00m%}"
    bold      "%{^[[01m%}" no-bold      "%{^[[22m%}"
    italic    "%{^[[03m%}" no-italic    "%{^[[23m%}"
    underline "%{^[[04m%}" no-underline "%{^[[24m%}"
    blink     "%{^[[05m%}" no-blink     "%{^[[25m%}"
    reverse   "%{^[[07m%}" no-reverse   "%{^[[27m%}"
)

for color in {000..255}; do
    FG[$color]="%{^[[38;5;${color}m%}"
    BG[$color]="%{^[[48;5;${color}m%}"
done

export FX
export FG
export BG
# }}}

# Include zprofile.local
[[ -e ${HOME}/.zprofile.local ]] && source ${HOME}/.zprofile.local

# cleanup {{{
unfunction path-prepend
unfunction cdpath-append

typeset -gU path fpath cdpath
# }}}

# vim:fdm=marker ft=zsh
