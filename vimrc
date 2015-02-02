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

Plug 'Shougo/neocomplete.vim'

"Plug 'scrooloose/syntastic'

Plug 'SirVer/ultisnips'
Plug 'darookee/vim-snippets'

Plug 'jiangmiao/auto-pairs'

Plug 'c9s/lftp-sync.vim'

Plug 'scrooloose/nerdcommenter'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'

Plug 'airblade/vim-gitgutter'

Plug 'IndexedSearch'
Plug 'roman/golden-ratio'

Plug 'tpope/vim-git'
Plug 'pangloss/vim-javascript'
Plug 'leshill/vim-json'
Plug 'StanAngeloff/php.vim'
Plug 'evidens/vim-twig'
Plug 'gorodinskiy/vim-coloresque'

Plug 'sjl/gundo.vim'

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

set laststatus=2
set ruler
set list
set lcs=trail:·,precedes:«,eol:↲,tab:▸\ ,extends:»
set showcmd
set shortmess=atI
set noshowmode

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

" Spelling
set spellfile=~/.vim/spell/de_local.utf-8.add
set nospell spelllang=de,en
nmap <silent> <LocalLeader>s :set spell!<CR>

set cryptmethod=blowfish

" Load matchit.vim
runtime! macros/matchit.vim
" Colors {{{
set background=light
colorscheme zenburn
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
nnoremap gp `[V`]

" Remove trailing whitespace with ,W
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>:nohl<CR>

" split lines (opposite of S-j)
nnoremap <leader>j gEa<CR><ESC>
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
" }}}
" VISUAL {{{
" Ack for word(s) in motion
" http://www.vimbits.com/bits/153
xnoremap <silent> <leader>a :<C-U>call <SID>AckMotion(visualmode())<CR>

" replace with <leader><C-r>
" (https://www.reddit.com/r/vim/comments/2l6adg/how_do_you_do_a_search_replace_to_minimize_the/clrvf69)
vnoremap <leader><C-r> "vy:%s/<C-r>v//g<Left><Left>
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
"let g:ctrlp_user_command = [
            "\ '.git',
            "\ 'cd %s && git ls-files . -co --exclude-standard |
            "\ grep -v -P "\.jpg$|\.png$|\.gif$"',
            "\ 'find %s -type f| grep -v -P "\.jpg$|\.png$|\.gif$"'
            "\ ]

" http://blog.patspam.com/2014/super-fast-ctrlp

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'

let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

let g:ctrlp_follow_symlinks = 1
let g:ctrlp_mruf_relative = 1
nnoremap <silent> _b :<C-u>CtrlPBuffer<CR>

" map <leader><C-t> :CtrlPTag<CR>
" }}}
" netrw (disabled) {{{
"let g:netrw_banner       = 0
"let g:netrw_keepdir      = 1
"let g:netrw_liststyle    = 3 " or 3
"let g:netrw_sort_options = 'i'
"nnoremap <silent> - :<C-u>Explore<CR>
" }}}
" NeoComplete {{{
"
" Use neocomplete.
let g:neocomplete#enable_at_startup                 = 1
let g:neocomplete#enable_omni_fallback              = 1
" Use smartcase.
let g:neocomplete#enable_smart_case                 = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern          = '\*ku\*'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif

let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

" Plugin key-mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()

augroup neocomplete_lock
    au!
    au FileType text NeoCompleteLock
    au FileType mail NeoCompleteLock
augroup END

" }}}
" Syntastics (disabled) {{{
" let g:syntastic_auto_loc_list        = 1
" let g:syntastic_auto_jump            = 1
" let g:syntastic_enable_highlighting  = 1
" let g:syntastic_enable_signs         = 1
" let g:syntastic_javascript_checkers  = ['jslint']
" let g:syntastic_php_checkers         = ['php']
" let g:syntastic_mode_map             = { 'mode': 'passive',
"             \ 'active_filetypes': ['ruby', 'php', 'python'],
"             \ 'passive_filetypes': [] }
" let g:syntastic_error_symbol         = '✗'
" let g:syntastic_style_error_symbol   = '✠'
" let g:syntastic_warning_symbol       = '∆'
" let g:syntastic_style_warning_symbol = '≈'

" map <LocalLeader>sc :SyntasticCheck<CR>

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
" Filetype specific {{{

" PHP Syntax
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
function s:MkNonExDir(file, buf)
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
