"
" Poor mans syntastic
" Thanks to /u/-romainl-
" and tomtom/checksyntax
"
setlocal errorformat=line\ %l\ column\ %c\ -\ %m
setlocal makeprg=tidy\ -eq

command! -buffer Make silent make % | silent redraw! | silent wincmd p | cwindow 3
autocmd! BufWritePost <buffer> Make

setlocal omnifunc=htmlcomplete#CompleteTags
