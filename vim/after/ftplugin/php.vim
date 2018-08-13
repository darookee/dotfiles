syntax sync minlines=100
syntax sync maxlines=500

setlocal nocursorline
setlocal regexpengine=1
setlocal synmaxcol=500
setlocal foldmethod=manual

"
" Poor mans syntastic
" Thanks to /u/-romainl-
" and tomtom/checksyntax
"
setlocal errorformat=%f:%l:%c:\ %m
setlocal makeprg=~/.bin/phplintcs

command! -buffer Make silent make % | silent redraw! | silent wincmd p | cwindow 3

setlocal omnifunc=phpcomplete#CompletePHP

" PDV - phpDocumentor
let g:pdv_template_dir = $HOME ."/.vim/plugged/pdv/templates_snip"
nnoremap <buffer> _gc :call pdv#DocumentWithSnip()<CR>

" php-accessors.vim
let g:phpacc_template_dir = $HOME . "/.vim/php-accessor-templates/"
nnoremap <buffer> _gs :call phpacc#GenerateAccessors()<CR>
vnoremap <buffer> _gs :call phpacc#GenerateAccessors()<CR>

let b:argwrap_tail_comma = 0

" disable a lot of syntax highlighting
let php_html_in_heredoc = 0
let php_html_in_nowdoc = 0
let php_sql_heredoc = 0
let php_sql_nowdoc = 0
let php_sql_query = 0
let php_ignore_phpdoc = 1
