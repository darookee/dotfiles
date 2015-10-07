#
# Executes commands at login post-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Nils Uliczka <nils.uliczka@darookee.net>
#

# Execute code that does not affect the current session in the background. {{{
{
  # Compile the completion dump to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!
# }}}
# Start programs and services {{{
# start keychain {{{
# export GPG_TTY for pinentry
export GPG_TTY=$( tty )
(( $+commands[keychain] && $+commands[get_keychain_keys] )) && eval `keychain --agents gpg,ssh --eval $( get_keychain_keys )`
# }}}
# Print a random, hopefully interesting, adage. {{{
if (( $+commands[fortune] )); then
  fortune -a
  print
fi
# }}}
# Connect to tmux {{{
if [[ -n "$SSH_TTY" && -z "$TMUX" && "$TERM" != "dumb"  ]]; then
    if (( $+commands[tmux]  )); then
        read -q "STARTTMUX?Connect to tmux session? "
        [[ "$STARTTMUX" == "y" ]] && (tmux attach -d || tmux)
    fi
fi
# }}}
# startx when on tty1 {{{
if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    read -q "STARTX?Start X? "
    [[ "$STARTX" == "y" ]] && exec startx
fi
# }}}
# }}}


# vim:fdm=marker ft=zsh
