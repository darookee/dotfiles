#
# Authors:
#   Nils Uliczka <nils.uliczka@darookee.net>
#

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
