typeset -gU path fpath
path=(~/.bin ~/.bin.untracked $path)

export EDITOR='vi'
export VISUAL='vi'
export PAGER='less'

if [[ -z "$LANG" ]]; then
    export LANG='en_US.UTF-8'
fi

export LESS='-F -g -i -M -R -S -w -X -z-4'

if [[ "${TMPDIR}" == "" ]]; then
    export TMPDIR="/tmp/$USER"
fi

if [[ -d "$TMPDIR" ]]; then
    mkdir -p -m 700 "$TMPDIR"
fi

export TMPPREFIX="${TMPDIR}/zsh"
if [[ -d "$TMPPREFIX" ]]; then
    mkdir -p -m 700 "$TMPPREFIX"
fi

