"
" Poor mans syntastic
" Thanks to /u/-romainl-
" and tomtom/checksyntax
"
" setlocal errorformat=%*[^:]: %m in %f on line %l
setlocal errorformat=%A%f:%l:\ %.%#error\ :\ %m,%-Z%p^,%-C%.%#
setlocal makeprg=xmllint

command! -buffer Make silent make % | silent redraw! | silent wincmd p | cwindow 3

setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
