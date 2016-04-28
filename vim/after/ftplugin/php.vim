setlocal nocursorline
syntax sync minlines=100
syntax sync maxlines=240
set synmaxcol=800

"
" Poor mans syntastic
" Thanks to /u/-romainl-
" and tomtom/checksyntax
"
setlocal errorformat=%f:%l:%c:\ %m
setlocal makeprg=~/.bin.untracked/phplintcs

command! -buffer Make silent make % | silent redraw! | silent wincmd p | cwindow 3
autocmd! BufWritePost <buffer> Make

setlocal omnifunc=phpcomplete#CompletePHP

" PDV - phpDocumentor
let g:pdv_template_dir = $HOME ."/.vim/plugged/pdv/templates_snip"
nnoremap <buffer> _gc :call pdv#DocumentWithSnip()<CR>

" php-accessors.vim
let g:phpacc_template_dir = $HOME . "/.vim/php-accessor-templates/"
nnoremap <buffer> _gs :call phpacc#GenerateAccessors()<CR>
vnoremap <buffer> _gs :call phpacc#GenerateAccessors()<CR>

let b:argwrap_tail_comma = 1
