set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
" File handling
Bundle 'sjl/gundo.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
" Autoinsert
Bundle 'scrooloose/nerdcommenter'
Bundle 'Raimondi/delimitMate'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-surround'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'ervandew/supertab'
"Bundle 'Shougo/neocomplcache'
" Line handling
Bundle 'YankRing.vim'
" External Commands
"Bundle 'mattn/gist-vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-eunuch'
Bundle 'kchmck/vim-coffee-script'
" Motion and search
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kana/vim-smartword'
Bundle 'IndexedSearch'
Bundle 'camelcasemotion'
Bundle 'LStinson/TagmaTasks'
Bundle 'AndrewRadev/splitjoin.vim'
"Bundle 'Rainbow-Parenthesis'
" Syntax
Bundle 'scrooloose/syntastic'
"Bundle 'chrisbra/csv.vim' " does not work so nice in putty
" Visual
Bundle 'roman/golden-ratio'
Bundle 'gregsexton/MatchTag'
"Bundle 'altercation/vim-colors-solarized'
"Bundle 'skammer/vim-css-color' " slow as...
Bundle 'darookee/vim-statline'
"Bundle 'millermedeiros/vim-statline'

colorscheme zellner

set modelines=0
set nowritebackup
set nobackup
set noswapfile
set hidden

" Tabstops
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smarttab

" filehandling
set encoding=utf-8
set scrolloff=3
"set autochdir
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set visualbell
set cursorline
set ttyfast
set ruler
set laststatus=2
set relativenumber
set pastetoggle=<F10>

" commenting
set fo+=o " insert on o
set fo-=r " don't insert on enter
set fo-=t " don't autoreap
set wildmode=longest,list
set backspace=indent,eol,start " powerfull backspace

" wrapping
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

" indentation
set autoindent
set cindent
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do,for,switch,case
set smartindent
set joinspaces

" searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" Syntax highlighting
syntax on
filetype plugin indent on

" Visual settings
set list
set listchars=tab:▸\ ,trail:▸,extends:>,precedes:<,eol:¬
set ruler
set showcmd
set shortmess=atI
set cursorline

" Filetypes
au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown
au BufRead,BufNewFile {COMMIT_EDITMSG} set ft=gitcommit
au BufRead,BufNewFile *.json set ft=javascript " highlight json like javascript

" iptables commentstring for NERDCommenter
if getline(1) =~ "^# Generated by iptables-save" || getline(1) =~ "^# Firewall configuration written by"
    setfiletype iptables
    set commentstring=#%s
    finish
endif

" restore position on read
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif

" save on focus lost
au FocusLost * :wa

" remap leader
let mapleader = ","
let maplocalleader = "-"

" disable keys
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

" remap search to center on line
map N Nzz
map n nzz

" edit and reload .vimrc
nnoremap <silent> <Leader>vrc :tabnew<CR>:e ~/.vimrc<CR>
nnoremap <silent> <Leader>rld :so ~/.vimrc<CR>

" toggle folds with space
nnoremap <space> za

" fold HTML Tags
nnoremap <leader>ft Vatzf

" create blank newlines
nnoremap <silent> <Leader>o o<Esc>
nnoremap <silent> <Leader>O O<Esc>

" Split line (oposite of S-J)
nnoremap <silent> <leader>j gEa<CR><ESC>ew

" Press ,W to remove trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>:nohl<CR>

" ,V to highlight pasted text
nnoremap <leader>v V`]

" escape with jj
inoremap jj <ESC>
inoremap <leader>ll <CR><ESC>O

" split window settings
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Ack
"noremap <leader>a :Ack

" syntactics
let g:syntastic_phpcs_disable = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_auto_jump = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_javascript_checker = 'jslint'

" Gundo
nnoremap <C-u> :GundoToggle<CR>

" NERDTree
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <leader><C-e> :NERDTreeFind<CR>

" PHP Specific bindings
" create getter and setter of protected var
nnoremap <Leader>pc mC:s/\(\(\w\)\(\w\+\)\).*/protected $\1;\r\rpublic function get\u\2\3(){\r\treturn \$this->\1;\r}\r\rpublic function set\u\2\3(\$\1){\r\t\$this->\1 = \$\1;\r\treturn $this;\r}/<CR>:nohl<CR>:retab<CR>mE`CV`E==
" convert array to object
nnoremap <Leader>n :s/\['\(.\{-}\)'\]/->\1/gc<CR>
" convert snake_case to camelCase
nnoremap <Leader>coc :s#_\(\l\)#\u\1#g<CR>

" YankRing
let g:yankring_replace_n_pkey='<C-M>'
let g:yankring_manual_clipboard_check = 0
nnoremap <silent> <F3> :YRShow<cr>
inoremap <silent> <F3> <ESC>:YRShow<cr>

" CtrlP
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_extensions = ['line']
let g:ctrlp_root_markers = ['templates/','engine/']

" statline
let g:statline_filename_relative = 1
let g:statline_show_filepath = 1
let g:statline_show_savetime = 1

" sparkup
"let g:sparkupExecuteMapping='<leader>s'
"let g:sparkupNextMapping='<leader>n'

" smartword
noremap ,w  w
noremap ,b  b
noremap ,e  e
noremap ,ge  ge
map w  <Plug>(smartword-w)
map b  <Plug>(smartword-b)
map e  <Plug>(smartword-e)
map ge  <Plug>(smartword-ge)

" splitjoin
nmap <Leader>sj :SplitjoinSplit<cr>
nmap <Leader>sk :SplitjoinJoin<cr>

" neocomplcache
"let g:neocomplcache_enable_at_startup = 1
"let g:neocomplcache_enable_smart_case = 1 " Use smartcase.
"let g:neocomplcache_enable_camel_case_completion = 1 " Use camel case completion.
"let g:neocomplcache_enable_underbar_completion = 1 " Use underbar completion.
"let g:neocomplcache_min_syntax_length = 3 " Set minimum syntax keyword length.
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"" Plugin key-mappings.
"imap <C-k>     <Plug>(neocomplcache_snippets_expand)
"smap <C-k>     <Plug>(neocomplcache_snippets_expand)
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>" " <TAB>: completion.
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTagsu

"if !exists('g:neocomplcache_omni_patterns')
    "let g:neocomplcache_omni_patterns = {}
"endif

"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

" misc filehandling stuff
"au FileType javascript nnoremap <silent> <leader>m :call JSminify()<CR>
au FileType javascript nnoremap <silent> <leader>mm :call JSminify()<CR>
au FileType scss nnoremap <silent> <leader>m :call SCSStocss()<CR>
au FileType scss nnoremap <silent> <leader>mm :call SCSStocssmin()<CR>
au FileType smarty call RagtagInit()
au FileType smarty runtime! ftplugin/html.vim
au FileType smarty set fileencoding=latin1

if !exists('*SCSStocss')
    function! SCSStocss()
        if match(bufname('%'), "_" ) != 0
            let dst = substitute( bufname('%'),'.scss','.css','g' )
            lcd %:p:h
            silent execute "w ! sass --scss --style expanded -s " . dst . " &> /dev/null"
        endif
    endfunction
endif

if !exists('*SCSStocssmin')
    function! SCSStocssmin()
        if match(bufname('%'), "_" ) != 0
            let dst = substitute( bufname('%'),'.scss','.css','g' )
            let mindst = substitute( dst, '.css', '.min.css', 'g' )
            lcd %:p:h
            silent execute "w ! sass --scss --style compressed -s " . mindst . " &> /dev/null"
        endif
    endfunction
endif

if !exists('*JSminify')
    function! JSminify()
        let dst = substitute( bufname('%'),'.js','.min.js','g' )
        lcd %:p:h
        silent execute "w ! yuicompressor --type js -o " . dst . " &> /dev/null"
    endfunction
endif
