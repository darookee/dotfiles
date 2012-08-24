session_root "~Dev/Kunden/${1}"

if initialize_session "${1}"; then
    load_window "${1}"
    select_window 0
fi

finalize_and_go_to_session
