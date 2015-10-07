" ~darookee/.vimrc
" Plug {{{
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
" }}}
set nocompatible
filetype off
" Plugins {{{
call plug#begin()
" File finder
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'jeetsukumaran/vim-filebeagle'

" Colors
Plug 'darookee/base16-vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Filetype
Plug 'evidens/vim-twig'
Plug 'shawncplus/phpcomplete.vim'

" snippets
Plug 'SirVer/ultisnips'
Plug 'darookee/vim-snippets'

" Text
Plug 'tpope/vim-surround'
Plug 'FooSoft/vim-argwrap'
call plug#end()
" }}}
" Colors {{{
set background=dark
let base16colorspace=256
colorscheme base16-monokai
" }}}
" Settings {{{
filetype plugin indent on
syntax on

" remove startup message
set shortmess=atI
set laststatus=2

" linenumbers, cursorposition
set number
set cursorline
set ruler
set scrolloff=5
set colorcolumn=81
set showmatch

" undo
set undodir=~/.vim/undodir
set undofile
set noswapfile

" whitespace
set expandtab
set tabstop=4
set shiftwidth=4
set textwidth=80

" search
set incsearch
set ignorecase
set smartcase
set gdefault
set hlsearch

set display+=lastline

set wildmenu
set wildignore+=*.swp,*.bak
set wildignore+=*.pyc
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=*/min/*,*/vendor/*,*/node_modules/*,*/bower_components/*
set wildignore+=*.tar.*
set wildignorecase
set wildmode=full

" Spelling
set spellfile=~/.vim/spell/de_local.utf-8.add
set nospell spelllang=de,en
nnoremap <silent> _s :set spell!<CR>

set backspace=indent,eol,start
set smarttab

set list
set listchars=tab:»·,eol:↲,nbsp:␣,extends:…
set showbreak=›››\

set hidden
" }}}
" Disable unused keys {{{
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
" }}}
" Leader {{{
set pastetoggle=<F10>
let mapleader = ","
" }}}
" INSERT {{{
inoremap jj <ESC>
" }}}
" NORMAL {{{
" Move over wrapped lines {{{
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
" }}}
nnoremap <space> za

" insert new line and go back to normal
nnoremap gO O<ESC>
nnoremap go o<ESC>

nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-l> <C-w>l
augroup windows
    " http://vimrcfu.com/snippet/186
    autocmd VimResized * :wincmd =
augroup END

" remove highlighting and redraw
nnoremap <silent> <BS> :nohlsearch<CR><C-L>

" highlight last paste
" from /u/Wiggledan
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Remove trailing whitespace with ,W
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>:nohl<CR>

" Break line, opposite of J
nnoremap <silent> S :call BreakHere()<CR>

" replace with <leader>r/R
" (https://www.reddit.com/r/vim/comments/2l6adg/how_do_you_do_a_search_replace_to_minimize_the/clrvf69)
nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <leader>R :%s/\<<C-r><C-a>\>//g<Left><Left>

" run current line in shell and replace line with output
" https://www.youtube.com/watch?v=MquaityA1SM
noremap Q !!$SHELL<CR>
" }}}
" COMMAND {{{
" expan %% to current path in commandline
cnoremap %% <C-R>=expand('%:h').'/'<CR>
" sudo write file
cmap w!! w !sudo tee > /dev/null %
" }}}
" VISUAL {{{
vnoremap <leader>r "vy:%s/<C-r>v//g<Left><Left>
" Move visual block
" http://vimrcfu.com/snippet/77
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" }}}
" Plugins {{{
" CtrlP {{{
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['line']
let g:ctrlp_by_filename = 1
let g:ctrlp_max_height = 30
let g:ctrlp_switch_buffer = 'EtVH'
let g:ctrlp_use_caching = 0
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_mruf_relative = 1

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
" CtrlP_StatusLine: {{{
" Arguments: focus, byfname, s:regexp, prv, item, nxt, marked
"            a:1    a:2      a:3       a:4  a:5   a:6  a:7
fu! CtrlP_main_status(...)
  let regex = a:3 ? 'regex %*' : ''
  let prv = '%#StatuslineDim# '.a:4.' %*'
  let item = '%#StatuslineHighlighted# '.a:5.' %*'
  let nxt = '%#StatuslineDim# '.a:6.' %*'
  let byfname = ' '.a:2.' %*'
  let dir = ' '.fnamemodify(getcwd(), ':~').' %*'
  retu  prv . item . nxt . '%=%*%<' . byfname . regex . dir
endf

" Argument: len
"           a:1
fu! CtrlP_progress_status(...)
  let len = '%#StatuslineHighlighted# '.a:1.' %*'
  let dir = ' %=%<%#StatuslineDim# '.getcwd().' %*'
  retu len.dir
endf

let g:ctrlp_status_func = {
  \ 'main': 'CtrlP_main_status',
  \ 'prog': 'CtrlP_progress_status'
  \}
" }}}
nnoremap <silent> _b :<C-u>CtrlPBuffer<CR>
" }}}
" ArgWrap {{{
nnoremap <silent> _a :ArgWrap<CR>
" }}}
" vim-surround {{{
" comment with ys<textobject>*
let b:surround_{char2nr("*")} = printf(&commentstring, " \r ")
" }}}
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
nnoremap K :<C-u>Grep <C-R><C-W>"<CR>
nnoremap _K :<C-u>Grep

" autoopen quickfix after grep
augroup Grep
    au!
    " http://vimrcfu.com/snippet/194
    autocmd QuickFixCmdPost grep,make,grepadd,vimgrep,vimgrepadd,cscope,cfile,cgetfile,caddfile,helpgrep cwindow
    autocmd QuickFixCmdPost lgrep,lmake,lgrepadd,lvimgrep,lvimgrepadd,lfile,lgetfile,laddfile lwindow
augroup END
" }}}
" Status{{{
" http://www.blaenkdenum.com/posts/a-simpler-vim-statusline/
function! Status(winnr)
    let stat = ''
    let active = winnr() == a:winnr
    let buffer = winbufnr(a:winnr)

    let modified = getbufvar(buffer, '&modified')
    let readonly = getbufvar(buffer, '&ro')
    let ftype = getbufvar(buffer, '&ft')
    let encoding = getbufvar(buffer, '&enc')
    let type = getbufvar(buffer, '&buftype')
    let fname = bufname(buffer)
    let filepath = fnamemodify(fname, ':p')
    let lineends = search('\s\+$', 'nw')

    function! Color(active, num, content)
        if a:active
            return '%#'.a:num.'#' . a:content . '%*'
        else
            return a:content
        endif
    endfunction

    let stat .= Color(active, 'StatuslineHighlighted', active ? ' » ' : ' « ')

    if type != ''
        let stat .= '%<'
        let stat .= Color(active, 'StatuslineHighlighted', type)
        return stat
    endif

    " column
    let stat .= '%#StatuslineDim#' . (line(".") / 100 >= 1 ?
                \ '%l' : ' %2l').'/%L'
    let stat .= ':' . (col(".") / 100 >= 1 ? '%v ' : ' %2v ')

    " file
    let stat .= '%<'

    if type != ''
        let stat .= Color(active, 'StatuslineHighlighted', type)
    else
        let stat .= Color(active, 'StatuslineHighlighted', '%f ').
                    \ '%#StatuslineDim#↺' .
                    \ strftime("%F %H:%M", getftime(filepath)) . ' '
    endif

    " file modified
    let stat .= Color(active, 'StatuslineWarning', modified ? '⇄ ' : '')

    " read only
    let stat .= Color(active, 'StatuslineAlert', readonly ? ' ' : '')

    if active
        if lineends != 0
            let stat .= Color(active, 'StatuslineAlert',
                        \ '␣ ')
        endif
    endif

    " paste
    if active && &paste
        let stat .= '%#StatuslineHighlighted#' . '⇣ ' . '%*'
    endif

    " right side
    let stat .= '%='

    let stat .= '%#StatuslineDim# '.ftype
    if encoding != 'utf-8'
        let stat .= '['.encoding.']'
    endif

    " git branch
    if exists('*fugitive#head')
        let head = fugitive#head(6)

        if empty(head) && exists('*fugitive#detect') && !exists('b:git_dir')
            call fugitive#detect(getcwd())
            let head = fugitive#head(6)
        endif
    endif

    if !empty(head)
        if exists("*gitgutter#hunk#hunks")
            let hunks = gitgutter#hunk#hunks()
            if empty(hunks)
                let git_color = 'StatuslinePositive'
            else
                let git_color = 'StatuslineAlert'
            endif
        else
            let git_color = 'StatuslineDim'
        endif
        let stat .= Color(active, git_color, '  '.head)
    endif

    return stat
endfunction

function! SetStatus()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!Status('.nr.')')
  endfor
endfunction

augroup status
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter,BufUnload * call SetStatus()
  autocmd Filetype qf call SetStatus()
augroup END
" }}}
" Custom Highlight{{{
augroup highlights
    au!
    autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
augroup END

hi ExtraWhitespace term=reverse ctermfg=15 ctermbg=9
hi StatuslineHighlighted ctermfg=4 ctermbg=18
hi StatuslinePositive ctermfg=2 ctermbg=18
hi StatuslineWarning ctermfg=5 ctermbg=18
hi StatuslineAlert ctermfg=1 ctermbg=18
hi StatuslineDim ctermfg=8 ctermbg=18
" }}}
" Functions{{{
" Mkdir on write if it does not exist {{{
function! MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction

augroup CreateDirOnWrite
    autocmd!
    autocmd BufWritePre * :call MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
" }}}

" split lines (opposite of S-j)
" from /u/-romainl-
" mapped to S
function! BreakHere()
    s/\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\r\3\5
    call histdel("/", -1)
endfunction

" http://www.vim.org/scripts/script.php?script_id=2724
function! Rename(name, bang)
    let l:curfile = expand("%:p")
    let l:curfilepath = expand("%:p:h")
    let l:newname = l:curfilepath . "/" . a:name
    let v:errmsg = ""
    silent! exe "saveas" . a:bang . " " . l:newname
    if v:errmsg =~# '^$\|^E329'
        if expand("%:p") !=# l:curfile && filewritable(expand("%:p"))
            silent exe "bwipe! " . l:curfile
            if delete(l:curfile)
                echoerr "Could not delete " . l:curfile
            endif
        endif
    else
        echoerr v:errmsg
    endif
endfunction

" http://snippetrepo.com/snippets/filter-quickfix-list-in-vim
function! s:FilterQuickfixList(bang, pattern)
  let cmp = a:bang ? '!~#' : '=~#'
  call setqflist(filter(getqflist(), "bufname(v:val['bufnr']) " . cmp . " a:pattern"))
endfunction
" }}}
" Filetypes {{{
" indenthtml
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

augroup FiletypeSettings
    au!
    autocmd BufNewFile,BufReadPost *.md set ft=markdown
    " http://vimrcfu.com/snippet/168
    autocmd FileType css,scss setlocal iskeyword+=-
augroup END

augroup QuickFix
    au!
    autocmd Filetype qf nnoremap <buffer> j j
    autocmd Filetype qf nnoremap <buffer> k k
augroup END
" }}}
" Commands{{{
" Rename current file
command! -nargs=* -complete=file -bang Rename :call Rename("<args>", "<bang>")
" Remove current file but don't close buffer
command! Remove :call delete(@%)
" past buffer to sprunge.us
command! -range=% SP  execute <line1> . "," . <line2> .
            \ "w !curl -F 'sprunge=<-' http://sprunge.us | tr -d '\\n'"
" http://snippetrepo.com/snippets/filter-quickfix-list-in-vim
command! -bang -nargs=1 -complete=file QFilter call
            \ s:FilterQuickfixList(<bang>0, <q-args>)
" }}}

" vim:fdm=marker
