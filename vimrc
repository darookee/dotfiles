set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
"
" File handling
Bundle 'sjl/gundo.vim'

"Bundle 'mbbill/undotree'
" <c-u>
"
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
" <c-e>

Bundle 'bling/vim-airline'

Bundle 'editorconfig/editorconfig-vim'

" Autoinsert
"Bundle 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/tComment'
Bundle 'Raimondi/delimitMate'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-surround'
"Bundle 'tpope/vim-endwise'
"Bundle 'EvanDotPro/php_getset.vim'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "darookee/ultisnips"
"Bundle 'MarcWeber/ultisnips'
"Bundle 'darookee/vim-snippets'
"
" Line handling
Bundle 'maxbrunsfeld/vim-yankstack'
" <c-m> <localleader><c-m>
"
" External Commands
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-eunuch'
Bundle 'kchmck/vim-coffee-script'
Bundle 'airblade/vim-gitgutter'

" Motion and search
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kana/vim-smartword'
Bundle 'IndexedSearch'
Bundle 'camelcasemotion'
Bundle 'LStinson/TagmaTasks'
Bundle 'AndrewRadev/splitjoin.vim'
" ,sj ,sk
"
Bundle 'jakobwesthoff/argumentrewrap'
" ,aw
"
" Syntax
Bundle 'scrooloose/syntastic'
Bundle 'chrisbra/csv.vim'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'vim-scripts/JavaScript-Indent'

"
" Visual
Bundle 'roman/golden-ratio'
Bundle 'vim-scripts/ZoomWin'
" <c-w>o
"
Bundle 'troydm/easybuffer.vim'
" ,bb
"
Bundle 'chrisbra/NrrwRgn'
" :<range>NR[!]
"
Bundle 'gregsexton/MatchTag'
Bundle 'altercation/vim-colors-solarized'

set background=light
colorscheme Tomorrow-Night

set modelines=5
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
set ttyfast
set ruler
set laststatus=2
set relativenumber
set pastetoggle=<F10>

if version >= 703
  set undodir=~/.vim/undodir
  set undofile
  set undoreload=10000
endif
set undolevels=1000

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

" setup yankstack
call yankstack#setup()

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

" Remove menu bar
set guioptions-=m

" Remove toolbar
set guioptions-=T

" spellfile
set spellfile=~/.vim/spell/de_local.utf-8.add

" Filetypes
au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown
au BufRead,BufNewFile {COMMIT_EDITMSG} set ft=gitcommit
au BufRead,BufNewFile *.json set ft=javascript " highlight json like javascript


" smarty filetype
au FileType smarty call RagtagInit()
au FileType smarty runtime! ftplugin/html.vim
au FileType smarty set fileencoding=latin1
au Filetype smarty exec('set dictionary=/home/user/.vim/syntax/smarty.vim')
au Filetype smarty set complete+=k

" mail filetype
au FileType mail setlocal fo=aw
au FileType mail setlocal spell spelllang=de
au FileType mail colorscheme solarized

" iptables
if getline(1) =~ "^# Generated by iptables-save" ||
            \ getline(1) =~ "^# Firewall configuration written by"
    setfiletype iptables
    set commentstring=#%s
    finish
endif

" restore position on read
au BufReadPost * if line("'\"") > 0 &&
            \ line("'\"") <= line("$") | execute "normal g'\"" | endif

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

" redirect last search matching lines to new buffer
nnoremap <silent> <localleader><c-f>
            \ :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>

" escape with jj
inoremap jj <ESC>

" insert new row (into brackets for example)
inoremap <leader>ll <CR><ESC>O

" expand %% to current filepath in commandline
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" highlight or don't highlight
nmap <leader>h :set hlsearch! hlsearch? <CR>

" split window settings
nnoremap <localleader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Argumentwrap
nnoremap <silent> <leader>aw :call argumentrewrap#RewrapArguments()<CR>

" syntactics
let g:syntastic_auto_loc_list = 1
let g:syntastic_auto_jump = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_javascript_checkers=['jslint']
let g:syntastic_php_checkers=['php']
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby', 'php', 'python'],
            \ 'passive_filetypes': [] }

map <leader>sc :SyntasticCheck<CR>

" Gundo
nnoremap <leader><C-u> :GundoToggle<CR>

" NERDTree
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <localleader><C-e> :NERDTreeFind<CR>

" phpDoc
imap <C-o> :set paste<CR>:exe PhpDoc()<CR>:set nopaste<CR>i
let g:pdv_cfg_Author = "Nils Uliczka <nils.uliczka@darookee.net>"
let g:pdv_cfg_Copyright = "2012 Nils Uliczka"
let g:pdv_cfg_License = ""

" Gist
let g:gist_detect_filetype = 1

" YankStack
nmap <C-M> <Plug>yankstack_substitute_older_paste
nmap <localleader><C-M> <Plug>yankstack_substitute_newer_paste
nnoremap <leader>p p`[v`]=

" easybuffer
map <leader>bb :EasyBuffer<CR>

" CtrlP
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['line']
let g:ctrlp_root_markers = ['templates/','engine/']
let g:ctrlp_by_filename = 1
let g:ctrlp_max_height = 20
let g:ctrlp_switch_buffer = 'EtVH'
let g:ctrlp_user_command = [
            \ '.git',
            \ 'cd %s && git ls-files . -co --exclude-standard |
            \ grep -v -P "\.jpg$|\.png$|\.gif$"',
            \ 'find %s -type f| grep -v -P "\.jpg$|\.png$|\.gif$"'
            \ ]
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_mruf_relative = 1
map <leader><C-p> :CtrlPBuffer<CR>

" smartword
map ww  <Plug>(smartword-w)
map bb  <Plug>(smartword-b)
map ee  <Plug>(smartword-e)
map gge  <Plug>(smartword-ge)
" use camelcase default keys

" splitjoin
nmap <Leader>sj :SplitjoinSplit<cr>
nmap <Leader>sk :SplitjoinJoin<cr>

" UltiSnips
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



" PHP Specific bindings
" convert array to object
nnoremap <localLeader>n :s/\['\(.\{-}\)'\]/->\1/gc<CR>
" convert snake_case to camelCase
nnoremap <localLeader>cc :s#_\(\l\)#\u\1#g<CR>
nnoremap <localleader>sc :s#\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2#g

" airline
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#csv#column_display = 'Name'

" airline custom parts
call airline#parts#define_function('lline', 'StatuslineLongLineWarning')
call airline#parts#define_minwidth('lline', 100)

call airline#parts#define_function('ch', 'StatuslineCurrentHighlight')
call airline#parts#define_minwidth('ch', 120)

call airline#parts#define_function('mtime', 'FileMTime')
call airline#parts#define_minwidth('mtime', 180)

" airline sections
let g:airline_section_c = airline#section#create([
            \ '%<',
            \ 'file',
            \ g:airline_symbols.space,
            \ 'mtime',
            \ g:airline_symbols.space,
            \ 'readonly'
            \ ])
let g:airline_section_gutter = airline#section#create([
            \ '%=',
            \ 'ch',
            \ g:airline_symbols.space,
            \ 'lline'
            \ ])
let g:airline_section_z = airline#section#create(
            \ [
            \ '%3P',
            \ g:airline_symbols.space,
            \ '%#__accent_bold#%3l%#__restore__#/%3L:%2c'
            \ ]
            \ )

" function for mtime
function! FileMTime()
    let file = expand("%:p")
    return '('.strftime("%c", getftime(file)).')'
endfunction

" functions for airline parts
" return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)
    let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
    return filter(line_lens, 'v:val > threshold')
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction


" Source simplenote vimrc {{{
let s:simplenoterc = expand($HOME . '/.simplenoterc')
if filereadable(s:simplenoterc)
    exec ':so ' . s:simplenoterc
endif
" }}}
