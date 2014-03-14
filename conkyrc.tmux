background        no
out_to_console    yes
update_interval   1
total_run_times   1
short_units   yes
pad_percents      3
mpd_host    192.168.0.1

TEXT
${if_match ${new_mails /home/darookee/.mail/darookee/INBOX/}>0}\#[fg=yellow]✉ \
\#[default]${new_mails /home/darookee/.mail/darookee/INBOX/}\#[default] \#[fg=grey]| ${endif}\
\#[fg=red]❤\#[fg=${if_match $acpitemp>35}red${else}green${endif}] $acpitemp°C \
\#[fg=${if_match $cpu>25}red${else}green${endif}][$cpu%]\#[default] \#[fg=grey]| \
${if_match "${addr eth1}"!="No Address"}\#[fg=blue]⍟ \#[fg=white]${addr eth1}${else}\#[fg=red]INTERNET${endif} \#[fg=grey]| \
\#[fg=cyan]≣ [h:${fs_free /home/darookee}]\#[default] \#[fg=grey]| \
\#[fg=yellow]${execi 21600 /home/darookee/.bin.untracked/weathermajig Braunschweig --short}\#[default] \#[fg=grey]| \
\#[fg=green][\#[fg=cyan]${time %a, %Y-%m-%d (%V)}\#[fg=white] ${time %H:%M:%S}\#[fg=green]]\#[default]\

# vim: set ft=conkyrc ts=4 sw=4 tw=79 foldmethod=manual :
