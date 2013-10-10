background        no
out_to_console    yes
update_interval   1
total_run_times   1
short_units   yes
pad_percents      3
mpd_host    192.168.0.1

TEXT
\#[fg=yellow](✉\#[default]${new_mails /home/darookee/.mail/darookee/INBOX/}\#[fg=yellow])\#[default] \
\#[fg=red]❤ $acpitemp°C [$cpu%]\#[default] \
\#[fg=blue](${addr eth2})ꜜ${downspeedf eth2}ꜛ${upspeedf eth2} \
#${if_mpd_playing}\#[fg=green]♪ ${mpd_smart 20} ${mpd_elapsed} ${endif}
\#[fg=cyan]≣ [$membar]\#[default] \
\#[fg=green][\#[fg=blue]${time %a, %Y-%m-%d (%V)}\#[fg=white] ${time %H:%M:%S}\#[fg=green]]\#[default]\
#\#[fg=white]${exec weathermajig Braunschweig --short}#[default]
