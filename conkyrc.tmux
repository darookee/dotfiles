background        no
out_to_console    yes
update_interval   1
total_run_times   1
short_units   yes
pad_percents      3
mpd_host    192.168.0.1

TEXT
${if_match ${new_mails /home/darookee/.mail/darookee/INBOX/}>0} \#[fg=colour179,bg=colour234,nobold]\#[bg=colour179,fg=colour168]✉ \
\#[fg=colour238]${new_mails /home/darookee/.mail/darookee/INBOX/} \#[bg=colour179,fg=colour236]\#[bg=colour236] ${else} \#[bg=colour234,fg=colour236]\#[bg=colour236] ${endif}\
\#[bg=colour236,fg=colour174]❤\#[fg=${if_match $acpitemp>35}colour174${else}colour150${endif}] $acpitemp°C \
\#[fg=${if_match $cpu>25}colour174${else}colour150${endif}][$cpu%]\#[fg=colour245,bg=colour236]\#[fg=${if_match $memperc>75}colour174${else}colour182${endif}][${memperc}%] \#[fg=colour238,bg=colour236]\#[bg=colour238] \
${if_match "${addr eth1}"!="No Address"}\#[fg=colour150]⍟ \#[fg=colour249]${addr eth1}${else}\#[fg=colour174]INTERNET${endif} \#[fg=colour249] \
\#[fg=colour150]≣\#[fg=colour249] [h:${fs_free /home/darookee}] \#[fg=colour237,bg=colour238]\#[bg=colour237] \
\#[fg=colour249]${execi 21600 /home/darookee/.bin.untracked/weathermajig Braunschweig --short} \#[fg=colour150,bg=colour237]\#[bg=colour150] \
\#[fg=colour238]${time %a, %Y-%m-%d (%V)}\#[fg=colour237]  \#[fg=colour238,bold]${time %H:%M} \#[fg=colour245,nobold,bg=colour238]\

# vim: set ft=conkyrc ts=4 sw=4 tw=79 foldmethod=manual :
