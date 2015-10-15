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
" setlocal errorformat=%f:%l:%c:\ %m
setlocal makeprg=php\ -l\ -n\ -d\ display_errors=1\ -d\ error_log=\ -d\ error_reporting=E_ALL\ %
" setlocal makeprg=~/.bin.untracked/phplintcs\ %

command! -buffer Make silent make % | silent redraw! | silent wincmd p | cwindow 3
autocmd! BufWritePost <buffer> Make

setlocal omnifunc=phpcomplete#CompletePHP

" PDV - phpDocumentor
let g:pdv_template_dir = $HOME ."/.vim/plugged/pdv/templates_snip"
nnoremap <buffer> <C-p> :call pdv#DocumentWithSnip()<CR>

" php-accessors.vim
let g:phpacc_template_dir = $HOME ."/.vim/plugged/php-accessors.vim/templates"
nnoremap <buffer> _gs :call phpacc#GenerateAccessors()<CR>
vnoremap <buffer> _gs :call phpacc#GenerateAccessors()<CR>


