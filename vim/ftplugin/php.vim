setlocal nocursorline
syntax sync minlines=100
syntax sync maxlines=240
set synmaxcol=800

"
" Poor mans syntastic
" Thanks to /u/-romainl-
" and tomtom/checksyntax
"
setlocal errorformat=%*[^:]:\ %m\ in\ %f\ on\ line\ %l
setlocal makeprg=php\ -l\ -n\ -d\ display_errors=1\ -d\ error_log=\ -d\ error_reporting=E_ALL\ %

command! -buffer Make silent make % | silent redraw! | silent wincmd p | cwindow 3
autocmd! BufWritePost <buffer> Make

setlocal omnifunc=phpcomplete#CompletePHP
