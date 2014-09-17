" ~darookee/.vimrc

if has('vim_starting') " Do stuff on startup {{{
    set nocompatible
    filetype off
" Download vim-plug if not exists {{{
    if !filereadable(expand('~/.vim/autoload/plug.vim'))
        echo "Installing vim-plug\n"
        silent execute '!mkdir -p ~/.vim/autoload'
        silent execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        source expand('~/.vim/autoload/plug.vim')
        execute 'PlugInstall!'
    endif
" }}}
endif
" }}}
call plug#begin() " Plugins {{{
Plug 'bling/vim-airline'

Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_unix.mak' }
Plug 'Shougo/unite.vim'

Plug 'Shougo/neocomplete.vim'

Plug 'scrooloose/syntastic'

Plug 'SirVer/ultisnips'
Plug 'darookee/vim-snippets'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'screooloose/nerdcommenter'

Plug 'airblade/vim-gitgutter'

Plug 'Raimondi/delimitMate'

Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'mattn/unite-gist'

Plug 'tommcdo/vim-lion'
Plug 'AndrewRadev/splitjoin.vim'

Plug 'IndexedSearch'
Plug 'roman/golden-ratio'

Plug 'tsukkee/unite-help'

let s:vimlocalpluginsrc = expand($HOME . '/.vim/local.plugins')
if filereadable(s:vimlocalpluginsrc)
    exec ':so ' . s:vimlocalpluginsrc
endif

call plug#end() " }}}
" enable plugins and syntax highlighting {{{
filetype plugin indent on
syntax enable
" }}}
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
colorscheme bubblegum
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
nnoremap j gj
nnoremap k gk
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
" expand %% to current filepath in commandline
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" split window settings
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" }}}
" PluginSettings {{{
" vim-airline {{{
let g:airline#extensions#csv#column_display = 'Name'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#syntastic#enabled = 1

let g:airline_powerline_fonts = 1

call airline#parts#define_function('mtime', 'FileMTime')
call airline#parts#define_minwidth('mtime', 160)

let g:airline_section_c = airline#section#create(['%<', 'file', g:airline_symbols.space, 'mtime', g:airline_symbols.space, 'readonly'])

" function for mtime
function! FileMTime()
    let file = expand("%:p")
    return '('.strftime("%c", getftime(file)).')'
endfunction

" }}}
" unite {{{
" enable yanks!
let g:unite_data_directory = '~/.vim/tmp/unite/'
let g:unite_source_history_yank_enable = 1
let g:unite_split_rule='botright'
let g:unite_prompt = '➜ '

let g:unite_source_grep_command = 'ack'
let g:unite_source_grep_default_opts = '--column --no-color --no-group'
let g:unite_source_grep_recursive_opt = ''

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_rec/async','sorters','sorter_rank')
call unite#custom#source('grep', 'matchers', 'matcher_fuzzy')

autocmd FileType unite call s:unite_settings()

fun! s:unite_settings()
  "Don't add parens to my filters
  let b:delimitMate_autoclose = 0

  "Keymaps inside the unite split
  nmap <buffer> <ESC> <Plug>(unite_exit)
  nmap <buffer> <nowait> <C-c> <Plug>(unite_exit)
  imap <buffer> <nowait> <C-c> <Plug>(unite_exit)

  imap <buffer> jj <Plug>(unite_insert_leave)

  nmap <buffer> <C-j> <Plug>(unite_select_next_line)
  nmap <buffer> <C-k> <Plug>(unite_select_previous_line)
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)

  nmap <silent><buffer><expr> <C-x> unite#do_action('split')
  nmap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')

endf

nnoremap - :Unite -no-split directory file file/new directory/new<CR>
nnoremap <C-P> :<C-u>Unite -buffer-name=files -start-insert buffer file_rec/git file_rec/async:! file/new line<CR>
nnoremap <Leader><C-a> :<C-u>Unite -start-insert grep:.<CR>
nnoremap <Leader><C-y> :<C-u>Unite history/yank<CR>
nnoremap <Leader><Tab> :<C-u>Unite ultisnips<CR>
" }}}
" NeoComplete {{{
"
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

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
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" }}}
" Syntastics {{{
let g:syntastic_auto_loc_list = 1
let g:syntastic_auto_jump = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_enable_signs = 1
let g:syntastic_javascript_checkers=['jslint']
let g:syntastic_php_checkers=['php']
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby', 'php', 'python'],
            \ 'passive_filetypes': [] }
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'

map <localleader>sc :SyntasticCheck<CR>

" }}}
" UltiSnips {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<right>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:snips_author = "Nils Uliczka"

fun! SnippetFilename(...)
    let template = get(a:000, 0, "$1")
    let arg2 = get(a:000, 1, "")

    let basename = expand('%:t:r')

    if basename == ''
        return arg2
    else
        return substitute(template, '$1', basename, 'g')
    endif
endf

" }}}
" delimitMate {{{
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 0
let delimitMate_jump_expansion = 1
let delimitMate_balance_matchpairs = 1
let delimitMate_excluded_ft = "mail,txt"
" }}}
" vim-gist {{{
let g:gist_detect_filetype = 1
let g:gist_show_private = 1
" }}}
" }}}

" vim:fdm=marker
