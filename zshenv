typeset -gU path fpath
path=(~/.bin ~/.bin.untracked $path)

EDITOR='vi'
VISUAL='vi'
PAGER='less'

if [[ -z "$LANG" ]]; then
    LANG='en_US.UTF-8'
fi

LESS='-F -g -i -M -R -S -w -X -z-4'

if [[ "${TMPDIR}" == "" ]]; then
    TMPDIR="/tmp/$USER"
fi

if [[ -d "$TMPDIR" ]]; then
    mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR}/zsh"
if [[ -d "$TMPPREFIX" ]]; then
    mkdir -p -m 700 "$TMPPREFIX"
fi

