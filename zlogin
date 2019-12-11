# compile zcompdump to speed up startup
{
    zcompdump=${ZSH_HOME}/zcompdump
    if [[ -s "${zcompdump}" && (! -s "${zcompdump}.zwc" || "${zcompdump}" -nt "${zcompdump}.zwc" ) ]]; then
        zcompile "${zcompdump}"
    fi
} &!

# set vars that are only needed in login shells
export GPG_TTY=$(tty)

# when connected via SSH ask for tmux
if [[ -n "$SSH_TTY" && -z "$TMUX" && "$TERM" != "dump" ]]; then
    if (( $+commands[tmux] )); then
        read -q "STARTTMUX?Connect to tmux session? "
        [[ "$STARTTMUX" == "y" ]] && (tmux attach -d || tmux)
    fi
fi

# ask for startx when on VT1
if [[ -z "$DISPLAY" && "$XDG_VTNR" -eq "1" ]]; then
    read -q "STARTX?Start X? "
    [[ "$STARTX" == "y" ]] && exec startx
fi
