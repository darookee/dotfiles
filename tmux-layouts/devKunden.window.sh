window_root "~/Dev/Kunden/${1}"

new_window "${1}"

run_cmd vi
split_v 25
split_h 50

select_pane 0
