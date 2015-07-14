" ~darookee/.vimrc

if has('vim_starting') " Do stuff on startup {{{
" Download vim-plug if not exists {{{
    if !filereadable(expand('~/.vim/autoload/plug.vim'))
        echo "Installing vim-plug\n"
        silent execute '!mkdir -p ~/.vim/autoload'
        silent execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        source $MYVIMRC
        execute 'PlugInstall!'
    endif
" }}}
endif
" }}}
" Plugins {{{
set nocompatible
filetype off

call plug#begin() 
Plug 'bling/vim-airline'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'jeetsukumaran/vim-filebeagle'

Plug 'dyng/ctrlsf.vim'


"Plug 'scrooloose/syntastic'

Plug 'SirVer/ultisnips'
Plug 'darookee/vim-snippets'

Plug 'cohama/lexima.vim'

Plug 'c9s/lftp-sync.vim'

"Plug 'scrooloose/nerdcommenter'
Plug 'tomtom/tcomment_vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'

Plug 'airblade/vim-gitgutter'

Plug 'IndexedSearch'
Plug 'roman/golden-ratio'

Plug 'tpope/vim-git'
Plug 'vim-scripts/JavaScript-Indent'
Plug 'leshill/vim-json'
Plug 'StanAngeloff/php.vim'
Plug 'shawncplus/phpcomplete.vim'
Plug 'evidens/vim-twig'
Plug 'gorodinskiy/vim-coloresque'
Plug 'chrisbra/vim-diff-enhanced'

Plug 'ludovicchabant/vim-gutentags'

Plug 'sjl/gundo.vim'

Plug 'chriskempson/base16-vim'

let s:vimlocalpluginsrc = expand($HOME . '/.vim/local.plugins')
if filereadable(s:vimlocalpluginsrc)
    exec ':so ' . s:vimlocalpluginsrc
endif

call plug#end() " }}}
filetype plugin indent on
syntax enable
" Configuration {{{
" Settings (partly taken from tpope/vim-sensible {{{

set autoindent
" set smartindent
set backspace=indent,eol,start
set smarttab

set nrformats-=octal

set ttimeout
set ttimeoutlen=50

set incsearch
set ignorecase
set smartcase
set gdefault

nnoremap / /\v
vnoremap / /\v

nnoremap ? ?\v
vnoremap ? ?\v

map N Nzz
map n nzz

" Use _<C-L> to clear the highlighting of :set hlsearch.
nnoremap <silent> _<C-L> :nohlsearch<CR><C-L>
nnoremap <silent><BS> :nohlsearch<CR>

set laststatus=2
set ruler
set list
set lcs=trail:·,precedes:«,eol:↲,tab:▸\ ,extends:»
set showcmd
set shortmess=atI
set noshowmode
set lazyredraw

set wildmenu
set wildmode=longest,list

set hidden
set nobackup
set noswapfile

set ttyfast

set pastetoggle=<F10>

set scrolloff=5
set sidescrolloff=5
set display+=lastline
set wrap
set showmatch

set textwidth=80
set formatoptions=n1cqj
set colorcolumn=81

set shiftwidth=4
set tabstop=4
set expandtab

set cursorline
set number

set foldlevelstart=2

set encoding=utf-8
set shell=/bin/zsh

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

set undodir=~/.vim/undodir
set undofile
set undoreload=10000
set undolevels=1000

" Autocompletion
set completeopt-=preview
set wildignore+=.git,vendor,node_modules,bower_components

" Spelling
set spellfile=~/.vim/spell/de_local.utf-8.add
set nospell spelllang=de,en
nmap <silent> <LocalLeader>s :set spell!<CR>

" Load matchit.vim
runtime! macros/matchit.vim
" Colors {{{
set background=dark
let g:rehash256 = 1
colorscheme base16-default
" }}}
" }}}
" Mappings {{{
" leader (, and \) {{{
let mapleader                                = ","
let maplocalleader                           = "\\"
" }}}
" disable some default keys {{{
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
" }}}
" INSERT {{{
" exit with jj
inoremap jj <ESC>
" }}}
" NORMAL {{{
" toggle folds with space
nnoremap <SPACE> za

" add new lines and exit insert mode
nnoremap gO O<ESC>
nnoremap go o<ESC>

" highlight last paste
" another version vom /u/Wiggledan
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Remove trailing whitespace with ,W
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>:nohl<CR>

" split lines (opposite of S-j)
"nnoremap <leader>j gEa<CR><ESC>
" another version vom /u/Wiggledan
nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>
"
" split window settings
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Ack for word(s) in motion
" http://www.vimbits.com/bits/153
nnoremap <silent> <leader>a :set opfunc=<SID>AckMotion<CR>g@

" replace with <leader>r/R
" (https://www.reddit.com/r/vim/comments/2l6adg/how_do_you_do_a_search_replace_to_minimize_the/clrvf69)
nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <leader>R :%s/\<<C-r><C-a>\>//g<Left><Left>

" run current line in shell and replace line with output
" https://www.youtube.com/watch?v=MquaityA1SM
noremap Q !!$SHELL<CR>

" toggle number and list
nnoremap <Leader><F10> :<C-u>call Toggle_copy_source()<CR>

fun! Toggle_copy_source()
    set number!
    set list!
    exe "GitGutterToggle"
endf
" }}}
" COMMAND {{{
" expand %% to current filepath in commandline
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" sudo write
cmap w!! w !sudo tee > /dev/null %
" }}}
" VISUAL {{{
" Ack for word(s) in motion
" http://www.vimbits.com/bits/153
xnoremap <silent> <leader>a :<C-U>call <SID>AckMotion(visualmode())<CR>

" replace with <leader><C-r>
" (https://www.reddit.com/r/vim/comments/2l6adg/how_do_you_do_a_search_replace_to_minimize_the/clrvf69)
vnoremap <leader><C-r> "vy:%s/<C-r>v//g<Left><Left>
" }}}
" OPENDING {{{
" from romainl
" http://stackoverflow.com/questions/11320083/is-there-a-way-to-get-integer-object-motions-in-vim
onoremap N  :<c-u>call <SID>NumberTextObject(0)<cr>
xnoremap N  :<c-u>call <SID>NumberTextObject(0)<cr>
onoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
onoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>

function! s:NumberTextObject(whole)
    normal! v

    while getline('.')[col('.')] =~# '\v[0-9]'
        normal! l
    endwhile

    if a:whole
        normal! o

        while col('.') > 1 && getline('.')[col('.') - 2] =~# '\v[0-9]'
            normal! h
        endwhile
    endif
endfunction
" }}}
" }}}
" PluginSettings {{{
" vim-airline {{{
let g:airline#extensions#csv#column_display  = 'Name'
let g:airline#extensions#branch#enabled      = 1
let g:airline#extensions#hunks#non_zero_only = 1
" let g:airline#extensions#syntastic#enabled   = 1

let g:airline_powerline_fonts                = 1

" Display File-Modification-Time
call airline#parts#define_function('mtime', 'Airline_FileMTime')
call airline#parts#define_minwidth('mtime', 160)

let g:airline_section_c = airline#section#create(['%<', 'file',
            \ g:airline_symbols.space, 'mtime', g:airline_symbols.space,
            \ 'readonly'])

" function for mtime
function! Airline_FileMTime()
    let file = expand("%:p")
    return '('.strftime("%c", getftime(file)).')'
endfunction

" }}}
" CtrlP {{{
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['line']
" let g:ctrlp_root_markers = ['templates/','engine/']
let g:ctrlp_by_filename = 1
let g:ctrlp_max_height = 30
let g:ctrlp_switch_buffer = 'EtVH'
let g:ctrlp_use_caching = 0
" http://blog.patspam.com/2014/super-fast-ctrlp

if executable('ag')
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
                \ --ignore .git
                \ --ignore .svn
                \ --ignore .hg
                \ --ignore .DS_Store
                \ --ignore "**/*.pyc"
                \ -g ""'
else
    let g:ctrlp_user_command = [
                \ '.git',
                \ 'cd %s && git ls-files . -co --exclude-standard |
                \ grep -v -P "\.jpg$|\.png$|\.gif$"',
                \ 'find %s -type f| grep -v -P "\.jpg$|\.png$|\.gif$"'
                \ ]
endif

let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

let g:ctrlp_follow_symlinks = 1
let g:ctrlp_mruf_relative = 1
nnoremap <silent> _b :<C-u>CtrlPBuffer<CR>
nnoremap <silent> _t :<C-u>CtrlPTag<CR>

" map <leader><C-t> :CtrlPTag<CR>
" }}}
" UltiSnips {{{
let g:UltiSnipsExpandTrigger              = "<tab>"
let g:UltiSnipsListSnippets               = "<right>"
let g:UltiSnipsJumpForwardTrigger         = "<tab>"
let g:UltiSnipsJumpBackwardTrigger        = "<s-tab>"

let g:snips_author                        = "Nils Uliczka"

fun! SnippetFilename(...)
    let template                          = get(a:000, 0, "$1")
    let arg2                              = get(a:000, 1, "")

    let basename                          = expand('%:t:r')

    if basename == ''
        return arg2
    else
        return substitute(template, '$1', basename, 'g')
    endif
endf

" }}}
" lftp-sync {{{
let g:lftp_sync_no_default_mapping        = 1
" }}}
" CtrlSF {{{
nnoremap _A :<C-u>CtrlSF 
" }}}
" Grep {{{
if executable('ag')
    command! -nargs=+ -complete=file_in_path -bar Grep silent! grep! <args> | cwindow 3 | redraw!
    set grepprg=ag\ --vimgrep
    set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ack')
    command! -nargs=+ -complete=file_in_path -bar Grep silent! grep! <args> | cwindow 3 | redraw!
    set grepprg=ack\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
nnoremap K :<C-u>Grep <C-R><C-W>"<CR>:cw<CR>
nnoremap _K :<C-u>Grep 
" }}}
" Filetype specific {{{

" PHP 
" Complete
let g:phpcomplete_relax_static_constraint = 1
let g:phpcomplete_complete_for_unknown_classes = 1
let g:phpcomplete_search_tags_for_variables = 1
let g:phpcomplete_parse_docblock_comments = 1

" Syntax
" highlight docblock
function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction

augroup syntaxCommands
    au!
    au FileType php call PhpSyntaxOverride()
    au BufNewFile,BufReadPost *.md set filetype=markdown
augroup END

" }}}
" }}}
" Functions {{{
" Ack for word(s) in motion {{{
" http://www.vimbits.com/bits/153
function! s:CopyMotionForType(type)
    if a:type ==# 'v'
        silent execute "normal! `<" . a:type . "`>y"
    elseif a:type ==# 'char'
        silent execute "normal! `[v`]y"
    endif
endfunction

function! s:AckMotion(type) abort
    let reg_save = @@
    call s:CopyMotionForType(a:type)
    execute "normal! :CtrlSF " . shellescape(@@) . "\<cr>"
    let @@ = reg_save
endfunction
" }}}
" Mkdir on write if it does not exist {{{
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
" }}}
" }}}
" }}}

" vim:fdm=marker
