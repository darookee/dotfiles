"
" Poor mans syntastic
" Thanks to /u/-romainl-
"
setlocal errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m
setlocal makeprg=eslint\ -f\ compact\ --quiet

command! -buffer Make silent make % | silent redraw! | silent wincmd p | cwindow 3

setlocal omnifunc=javascriptcomplete#CompleteJS
