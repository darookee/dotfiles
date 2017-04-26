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
    zgen load rimraf/k
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
# Source ~/.zsh/*.zsh {{{
for r in ${HOME}/.zsh/*.zsh; do
  if [[ $DEBUG > 0 ]]; then
    echo "zsh: sourcing $r"
  fi
  source $r
done
# }}}
# includes (rvm,gvm,...) {{{
#
# include rvm/gvm if exists
#
if [[ -d "${HOME}/.rvm" ]]; then
    [[ -s "${HOME}/.rvm/scripts/rvm" ]] && source "${HOME}/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi
if [[ -d "${HOME}/.gvm" ]]; then
    [[ -s "${HOME}/.gvm/scripts/gvm" ]] && source "${HOME}/.gvm/scripts/gvm"
fi
# export WORKON_HOME and include virtualenvwrapper if it exists
export WORKON_HOME="${HOME}/.venvs/"
if [[ -d "${WORKON_HOME}" ]]; then
    [[ -s "${HOME}/.local/bin/virtualenvwrapper.sh" ]] && source ${HOME}/.local/bin/virtualenvwrapper.sh
fi

if [ -f /opt/google-cloud-sdk/completion.zsh.inc ]; then
    source /opt/google-cloud-sdk/completion.zsh.inc
fi

# source kubectl completion
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# }}}
# include zshrc.local {{{
[[ -e ${HOME}/.zshrc.local ]] && source ${HOME}/.zshrc.local
# }}}

# vim:fdm=marker ft=zsh
