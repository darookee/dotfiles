"
" Poor mans syntastic
" Thanks to /u/-romainl-
"
" pylint + pyflakes... wth
setlocal errorformat=%A%f:%l:%c:%t:\ %m
setlocal makeprg=pylint\ -f\ parseable\ --msg-template="{path}:{line}:{column}:{C}:\ [{symbol}]\ {msg}"\ -r\ n\ -i\ y

command! -buffer Make silent make % | silent redraw! | silent wincmd p | cwindow 3
" autocmd! BufWritePost <buffer> Make
setlocal omnifunc=pythoncomplete#Complete

set tabstop=4     " a hard TAB displays as 4 columns
set shiftround    " round indent to multiple of 'shiftwidth'
