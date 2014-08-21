" darookee vimrc

" Plug {{{
set nocompatible
filetype off

"set rtp+=~/.vim/bundle/vundle/
"call vundle#begin()
call plug#begin('~/.vim/plugged')

" File handling {{{
Plug 'sjl/gundo.vim'
" Undoviewer

Plug 'ctrlpvim/ctrlp.vim'
" Fuzzyfinder

Plug 'scrooloose/nerdtree'
" Filebrowser
" <c-e>

Plug 'dhruvasagar/vim-vinegar'
" Use Nerdtree in current window

"Plug 'chrisbra/CheckAttach'
" Check for attachments in mails

" }}}
" Statusline {{{
Plug 'bling/vim-airline'
" }}}
" Autoinsert Text {{{
Plug 'scrooloose/nerdcommenter'
" Toggle comments

Plug 'Raimondi/delimitMate'
" Autoinsert closing brackets

Plug 'tpope/vim-ragtag'
" HTML-Hotkeys

Plug 'tpope/vim-speeddating'
" In- and decrement dates

Plug 'tpope/vim-surround'
" ysw( -> (hallo)

Plug 'SirVer/ultisnips'
Plug 'darookee/vim-snippets'
" Snippets

Plug 'Shougo/neocomplete.vim'
" Omnicomplete

Plug 'arecarn/crunch'
" Calculate math expressions

" }}}
" External Commands {{{
" git {{{
Plug 'tpope/vim-fugitive'
" use git in vim
Plug 'airblade/vim-gitgutter'
" Display git diff signs in sign col
Plug 'idanarye/vim-merginal'
" git branch buffer
" }}}
Plug 'tpope/vim-eunuch'
" Rename and Move files

Plug 'mileszs/ack.vim'
" Use ack for filecontent finding

" }}}
" Motion and search {{{
Plug 'Lokaltog/vim-easymotion'
" move by find

Plug 'bkad/CamelCaseMotion'
" move by camelcase

Plug 'IndexedSearch'
" Display searchresultcount

Plug 'kshenoy/vim-signature'
" Use marks

" }}}
" Textformat {{{
Plug 'AndrewRadev/splitjoin.vim'
" Split and join lines and arguments

Plug 'jakobwesthoff/argumentrewrap'
" Split arguments
" ,aw

Plug 'tommcdo/vim-lion'
" Align on =

" }}}
" Syntax {{{
Plug 'scrooloose/syntastic'
" Check syntax

Plug 'othree/xml.vim'
" XML-Syntax + tools

Plug 'Valloric/MatchTagAlways'
" Display matching xml + html tags

"Plug 'sheerun/vim-polyglot'
" multiple language syntax and indent configuration

Plug 'chrisbra/csv.vim'
" csv tools

Plug 'stephpy/vim-php-cs-fixer'
" php fixer

"Plug "Chiel92/vim-autoformat"
" Autoformat files


" }}}
" Visual {{{
Plug 'roman/golden-ratio'
" Change windowsize on selection change
" }}}

let s:vimlocalpluginsrc = expand($HOME . '/.vim/local.plugins')
if filereadable(s:vimlocalpluginsrc)
    exec ':so ' . s:vimlocalpluginsrc
endif

"call vundle#end()
call plug#end()

" }}}
" Basic settings {{{
set encoding=utf-8
set scrolloff=3
set modelines=5
set autoindent
set showmode
set showcmd
set hidden
set nobackup
set nowritebackup
set noswapfile
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
" }}}
" Modemappings {{{
set wildmode=longest,list
set backspace=indent,eol,start " powerfull backspace
" }}}
" Wrapping {{{
set wrap
set textwidth=79
set formatoptions=n1cq
set colorcolumn=80
" }}}
" Indentation {{{
set autoindent
set cindent
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do,for,switch,case
set smartindent
set joinspaces
" Tabstops {{{
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
" }}}
" }}}
" Searching {{{
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
" }}}
" Syntax highlighting {{{
syntax on
filetype plugin indent on
" }}}
" Visual settings {{{
set list
set listchars=trail:·,precedes:«,extends:»,eol:↲,tab:▸\ 
set ruler
set showcmd
set shortmess=atI
set cursorline

" Remove menu bar
set guioptions-=m

" Remove toolbar
set guioptions-=T

set background=light
colorscheme bubblegum

" restore position on read
au BufReadPost * if line("'\"") > 0 &&
            \ line("'\"") <= line("$") | execute "normal g'\"" | endif

" }}}
" Spell {{{
set spellfile=~/.vim/spell/de_local.utf-8.add
setlocal spelllang=de
nmap <silent> <localleader>s :set spell!<CR>
" }}}
" Filetypes {{{
" Markdown {{{
au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=ghmarkdown
" }}}
" Git-Commit {{{
au BufRead,BufNewFile {COMMIT_EDITMSG} set ft=gitcommit
" }}}
" json-as-javascript {{{
"au BufRead,BufNewFile *.json set ft=javascript " highlight json like javascript
" }}}
" phtml {{{
au BufRead,BufNewFile *.phtml set ft=phtml
" }}}
" smarty {{{
au FileType smarty call RagtagInit()
au FileType smarty runtime! ftplugin/html.vim
au FileType smarty set fileencoding=latin1
au Filetype smarty exec('set dictionary=/home/user/.vim/syntax/smarty.vim')
au Filetype smarty set complete+=k
" }}}
" mails {{{
au FileType mail NeoCompleteLock " disable neocomplete for mails
au FileType mail setlocal nonumber
au FileType mail setlocal formatprg=par-format\ -q\ -e
"au FileType mail setlocal textwidth=0
"au FileType mail setlocal wrapmargin=0
"au FileType mail setlocal wrap
au FileType mail setlocal spell spelllang=de
" }}}
" Iptables {{{
if getline(1) =~ "^# Generated by iptables-save" ||
            \ getline(1) =~ "^# Firewall configuration written by"
    setfiletype iptables
    set commentstring=#%s
    finish
endif
" }}}
" }}}
" Keymappings {{{
" Leader {{{
let mapleader = ","
let maplocalleader = "\\"
" }}}
" disable keys {{{
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
" remap search to center on line {{{
map N Nzz
map n nzz
" }}}
" edit and reload .vimrc {{{
nnoremap <silent> <Leader>vrc :tabnew<CR>:e ~/.vimrc<CR>
nnoremap <silent> <Leader>rld :so ~/.vimrc<CR>
" }}}

" toggle folds with space
nnoremap <space> za

" fold HTML Tags
nnoremap gft Vatzf

" create blank newlines
nnoremap <silent> go o<Esc>
nnoremap <silent> gO O<Esc>

" Split line (oposite of S-J)
nnoremap <silent> <leader>j gEa<CR><ESC>ew

" Press ,W to remove trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>:nohl<CR>

"  to highlight pasted text
nnoremap gp `[v`]

" redirect last search matching lines to new buffer
nnoremap <silent> <localleader>f
            \ :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>

" escape with jj
inoremap jj <ESC>

" expand %% to current filepath in commandline
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" highlight or don't highlight
nmap <leader>h :set hlsearch! hlsearch? <CR>

" split window settings
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}
" Plugin-Settings {{{
" Argumentwrap {{{
nnoremap <silent> <leader>aw :call argumentrewrap#RewrapArguments()<CR>
" }}}
" syntactics (Check with <localleader>sc){{{
let g:syntastic_auto_loc_list = 1
let g:syntastic_auto_jump = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_enable_signs = 1
let g:syntastic_javascript_checkers=['jslint']
let g:syntastic_php_checkers=['php']
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby', 'php', 'python'],
            \ 'passive_filetypes': [] }

map <localleader>sc :SyntasticCheck<CR>
" }}}
" Gundo (toggle with <localleader><C-e>){{{
nnoremap <localleader><C-e> :GundoToggle<CR>
" }}}
" NERDTree (use - to open in current buffer, <C-e> to toggle + <leader><C-e>to open and find file) {{{
let g:NERDTreeHijackNetrw = 1
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <leader><C-e> :NERDTreeFind<CR>
" netrw
" let g:netrw_liststyle = 3
" }}}
" CtrlP {{{
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['line']
" let g:ctrlp_root_markers = ['templates/','engine/']
let g:ctrlp_by_filename = 1
let g:ctrlp_max_height = 25
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
" map <leader><C-t> :CtrlPTag<CR>
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
" matchtagalways {{{
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'smarty' : 1,
    \ 'phtml' : 1,
    \}
" }}}
" airline {{{
let g:airline#extensions#csv#column_display = 'Name'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#syntastic#enabled = 1

let g:airline_powerline_fonts = 1

" airline custom parts
call airline#parts#define_function('lline', 'StatuslineLongLineWarning')
call airline#parts#define_minwidth('lline', 180)

call airline#parts#define_function('ch', 'StatuslineCurrentHighlight')
call airline#parts#define_minwidth('ch', 170)

call airline#parts#define_function('mtime', 'FileMTime')
call airline#parts#define_minwidth('mtime', 160)

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
" }}}
" delimitMAte {{{
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 0
let delimitMate_jump_expansion = 1
let delimitMate_balance_matchpairs = 1
let delimitMate_excluded_ft = "mail,txt"
au FileType html let b:delimitMate_quotes = "\" '"
au FileType phtml,html,smarty let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
" }}}
" Neocomplete {{{

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
" easymotion {{{
let g:EasyMotion_smartcase = 1

nmap s <Plug>(easymotion-s2)

map <leader><leader>j <Plug>(easymotion-j)
map <leader><leader>k <Plug>(easymotion-k)

" }}}
" Crunch {{{
map <unique> <localleader>cl <Plug>CrunchEvalLine
map <unique> <localleader>cb <Plug>CrunchEvalBlock
" }}}
" php-cs-fixer {{{
let g:php_cs_fixer_path = "~/.bin.untracked/php-cs-fixer" " define the path to the php-cs-fixer.phar
let g:php_cs_fixer_level = "all"                  " which level ?
let g:php_cs_fixer_config = "default"             " configuration
let g:php_cs_fixer_php_path = "php"               " Path to PHP
" If you want to define specific fixers:
let g:php_cs_fixer_fixers_list = "-braces"
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
" }}}
" }}}
" Misc {{{
" Useful from http://www.askapache.com/linux/fast-vimrc.html
" FUNCTION - AppendModeline {{{
" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline
function! AppendModeline()
    let l:modeline = printf(
                \ " vim: set ft=%s ts=%d sw=%d tw=%d foldmethod=%s :",
                \ &filetype,
                \ &tabstop,
                \ &shiftwidth,
                \ &textwidth,
                \ &foldmethod
                \ )
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
endfunction
" }}}
" FUNCTION - LastModNow {{{3
function! LastModNow()
    let l:updateline = printf(
                \ ' Updated: %s by %s ',
                \ strftime("%c"),
                \ expand("$USER")
                \ )
    let l:updateline = substitute(&commentstring, "%s", l:updateline, "")
    let @d = l:updateline
endfunction

map <silent> <localLeader>ml :call AppendModeline()<cr>
map <silent> <localLeader>mn :call LastModNow()<cr>
" }}}
" Encryption {{{
" GPG {{{
" Transparent editing of encrypted files (from
" http://vim.wikia.com/wiki/Encryption)
" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff
augroup encrypted
    au!

    " First make sure nothing is written to ~/.viminfo while editing
    " an encrypted file.
    autocmd BufReadPre,FileReadPre *.gpg set viminfo=
    " We don't want a various options which write unencrypted data to disk
    autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup

    " Switch to binary mode to read the encrypted file
    autocmd BufReadPre,FileReadPre *.gpg set bin
    autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
    " (If you use tcsh, you may need to alter this line.)
    autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt --use-agent 2> /dev/null

    " Switch to normal mode for editing
    autocmd BufReadPost,FileReadPost *.gpg set nobin
    autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

    " Convert all text to encrypted text before writing
    " (If you use tcsh, you may need to alter this line.)
    autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self --use-agent -ae 2>/dev/null
    " Undo the encryption so we are back in the normal text, directly
    " after the file has been written.
    autocmd BufWritePost,FileWritePost *.gpg u
augroup END
"
" }}}
" Crypt {{{
augroup CPT
    au!
    au BufReadPre *.cpt set bin
    au BufReadPre *.cpt set viminfo=
    au BufReadPre *.cpt set noswapfile
    au BufReadPost *.cpt let $vimpass = inputsecret("Password: ")
    au BufReadPost *.cpt silent '[,']!ccrypt -cb -E vimpass
    au BufReadPost *.cpt set nobin
    au BufWritePre *.cpt set bin
    au BufWritePre *.cpt '[,']!ccrypt -e -E vimpass
    au BufWritePost *.cpt u
    au BufWritePost *.cpt set nobin
augroup END
" }}}
" }}}
" }}}

" vim:fdm=marker
