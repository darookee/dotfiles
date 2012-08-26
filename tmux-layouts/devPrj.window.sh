window_root "`~/.bin.untracked/prj info "${1}"`"

new_window "${1}"

run_cmd vi +CtrlP
split_v 25
split_h 50

select_pane 0
