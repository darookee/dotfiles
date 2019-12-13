# LANG
if [[ -z "$LANG" ]]; then
    export LANG="en_US.UTF-8"
fi

# TERM
if [[ -n "$TMUX" ]]; then
    export TERM="screen-256color"
fi

# PATH
function path-prepend {
    [[ -d "$1" ]] && path[1,0]=($1)
}

path-prepend "${HOME}/.bin"
path-prepend "${HOME}/.bin.untracked"
path-prepend "${HOME}/.bin.docker"
path-prepend "${HOME}/.local/bin"
path-prepend "${HOME}/.config/composer/vendor/bin"
[[ ! -z "$GOPATH" ]] && path-prepend "${GOPATH}/bin"

unfunction path-prepend

# EDITOR
if (( $+commands[nvim] )); then
    export EDITOR="nvim"
elif (( $+commands[vim] )); then
    export EDITOR="vim"
else
    export EDITOR="nano"
fi
export VISUAL=$EDITOR

# PAGER
export PAGER="less"
export LESS="-F -g -i -M -R -S -w -X -z-4"

# TMPDIR
[[ "${TMPDIR}" == "" ]] && export TMPDIR=${HOME}/.tmp
[[ ! -d "${TMPDIR}" ]] && mkdir -p -m 700 ${TMPDIR}

# ANSIBLE_VAULT_PASSWORD_FILE
[[ -e "${HOME}/.vault_password" ]] && export ANSIBLE_VAULT_PASSWORD_FILE="${HOME}/.vault_password"

# source .zshenv.local if it exists
[[ -e ${HOME}/.zshenv.local ]] && source ${HOME}/.zshenv.local

# vim:fdm=marker ft=zsh
