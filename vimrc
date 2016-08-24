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
Plug 'dracula/vim'
Plug 'ewilazarus/preto'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Filetype
Plug '2072/PHP-Indenting-for-VIm'
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv'
Plug 'tobyS/php-accessors.vim'
Plug 'othree/html5.vim'
Plug 'nvie/vim-flake8'
Plug 'beyondwords/vim-twig'
Plug 'kana/vim-textobj-user' | Plug 'whatyouhide/vim-textobj-xmlattr'

" snippets
Plug 'SirVer/ultisnips'
Plug 'darookee/vim-snippets'
Plug 'mattn/emmet-vim'

" Text
Plug 'tpope/vim-surround'
Plug 'FooSoft/vim-argwrap'
Plug 'cohama/lexima.vim'

" navigation
Plug 'rhysd/clever-f.vim'
Plug 'ggVGc/vim-fuzzysearch'
Plug 'mbbill/undotree'
Plug 'naddeoa/vim-visual-page-percent'
call plug#end()
" }}}
" Colors {{{
set background=dark
" colorscheme dracula
colorscheme preto
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
let &l:colorcolumn='+' . join(range(0, 254), ',+')
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
set timeout
set ttimeoutlen=100
set timeoutlen=750

set wildmenu
set wildignore+=*.swp,*.bak
set wildignore+=*.pyc
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=*/min/*,*/vendor/*,*/node_modules/*,*/bower_components/*
set wildignore+=*.tar.*
set wildignorecase
set wildmode=full

set completeopt-=preview

" Spelling
set spellfile=~/.vim/spell/local.utf-8.de.add
set nospell spelllang=de,en
nnoremap <silent> _s :set spell!<CR>

set backspace=indent,eol,start
set smarttab

set formatoptions=tcql1n

set list
set listchars=tab:»·,eol:↲,nbsp:␣,extends:…
if has('linebreak')
  set breakindent
  let &showbreak = '↳ '
  set cpo+=n
end
" Thanks /u/Bloodshot25
" https://www.reddit.com/r/vim/comments/3r8p6x/do_any_of_you_vim_users_use_a_4k_display/cwmen38
set fillchars=vert:│,fold:┈

set updatetime=1000

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

" toggle lists and numbers
nnoremap _<F10> :setlocal list! number!<CR>
" }}}
" COMMAND {{{
" expan %% to current path in commandline
cnoremap %% <C-R>=expand('%:h').'/'<CR>
" sudo write file
cmap w!! w !sudo tee > /dev/null %
" }}}
" VISUAL {{{
" replace with <leader>r/R
" (https://www.reddit.com/r/vim/comments/2l6adg/how_do_you_do_a_search_replace_to_minimize_the/clrvf69)
vnoremap <leader>r "vy:%s/<C-r>v//g<Left><Left>

" Move visual block
" http://vimrcfu.com/snippet/77
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Align columns
vnoremap _= :!column -t -o" "<CR>gv=
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
" {{{ lexima.vim
call lexima#add_rule({
            \ 'char': '%',
            \ 'at': '{\%#',
            \ 'input': '% ',
            \ 'input_after': ' %',
            \ 'filetype': ['html.twig', 'twig']
            \ })

call lexima#add_rule({
            \ 'char': '{',
            \ 'at': '{\%#',
            \ 'input': '{ ',
            \ 'input_after': ' }',
            \ 'filetype': ['html.twig', 'twig']
            \ })
" }}}
" vim-polyglot {{{
" let g:polyglot_disabled = ['css', 'php', 'json']
" }}}
" vim-fuzzysearch {{{
let g:fuzzysearch_match_spaces = 1

nmap _/ :FuzzySearch<CR>
" }}}
" undotree {{{
nnoremap <F5> :UndotreeToggle<CR>
" }}}
" visual-page-percent {{{
let g:visualPagePercent_display_width = 8
" }}}
" emmet-vim {{{
let g:user_emmet_install_global = 0
autocmd FileType html,css,html.twig EmmetInstall
" }}}
" }}}
" Grep {{{
command! -nargs=+ -complete=file_in_path -bar Grep silent! grep! <args> | cwindow 3 | redraw!
if executable('sift')
    set grepprg=sift\ -nMs\ --no-color\ --binary-skip\ --column\ --no-group\ --git\ --follow
    set grepformat=%f:%l:%c:%m
elseif executable('ag')
    set grepprg=ag\ --vimgrep\ --ignore=\"**.min.js\"
    set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ack')
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

    if active
        if type != ''
            let stat .= '%<'
            let stat .= Color(active, 'StatuslineHighlighted', type)
            return stat
        endif

        " column
        let stat .= '%#StatuslineDim# %3l/%L'
        let stat .= ':' . (col(".") / 100 >= 1 ? '%v ' : ' %2v ')
        let stat .= '%{VisualPercent()} '
    endif

    " file
    let stat .= '%<'

    if active
        if type != ''
            let stat .= Color(active, 'StatuslineHighlighted', type)
        else
            let stat .= Color(active, 'StatuslineHighlighted', '%f').
                        \ '%#StatuslineDim# ↺' .
                        \ strftime("%F %H:%M", getftime(filepath)) . ' '
        endif

        " file modified
        let stat .= Color(active, 'StatuslineWarning', modified ? ' ⇄ ' : '')

        " read only
        let stat .= Color(active, 'StatuslineAlert', readonly ? '  ' : '')

        if active
            if lineends != 0
                let stat .= Color(active, 'StatuslineAlert',
                            \ ' ␣ ')
            endif
        endif

        " paste
        if active && &paste
            let stat .= '%#StatuslineHighlighted#' . '⇣' . '%*'
        endif
    else
        if type != ''
            let stat .= Color(active, 'StatuslineHighlighted', type)
        else
            let stat .= Color(active, 'StatuslineHighlighted', '%f')
        endif
    endif

    " right side
    let stat .= '%='

    if active
        let stat .= '%#StatuslineDim# '.ftype
        if encoding != 'utf-8'
            let stat .= '['.encoding.']'
        endif

        let stat .= ' '

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
    autocmd Syntax * syn match Error '–'

    " Cursor line only on active window
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline

    " custom highlights
    autocmd ColorScheme * call AddCustomHighlights()
    autocmd VimEnter * call AddCustomHighlights()
augroup END

function! AddCustomHighlights()
    hi StatusLine ctermfg=0 ctermbg=8 cterm=none
    hi StatusLineNC ctermfg=0 ctermbg=8 cterm=none

    hi StatuslineDim ctermfg=8 ctermbg=0
    hi StatuslineHighlighted ctermfg=7 ctermbg=0

    hi StatuslinePositive ctermfg=8 ctermbg=2
    hi StatuslineWarning ctermfg=8 ctermbg=3
    hi StatuslineAlert ctermfg=7 ctermbg=1

    hi CursorLine ctermbg=0
    hi VertSplit ctermbg=none ctermfg=8
    hi Search cterm=reverse
    hi SearchCurrent ctermbg=blue

    hi MatchParent ctermfg=9

    hi ExtraWhitespace ctermfg=1 ctermbg=1
    hi SpellBad cterm=underline
    hi SpellCap cterm=underline
    hi SpellLocal cterm=underline
    hi SpellRare cterm=underline

    hi WildMenu ctermfg=2 ctermbg=8

    hi qfFileName ctermfg=8
    hi Directory ctermfg=8

    if g:colors_name == 'dracula'
        hi Visual cterm=reverse
        hi phpStructure ctermfg=4
    endif
endfunction
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
    autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
    autocmd FileType text,markdown setlocal nonumber spell
augroup END

augroup QuickFix
    au!
    autocmd Filetype qf nnoremap <buffer> j j
    autocmd Filetype qf nnoremap <buffer> k k

    autocmd Filetype qf setlocal nonumber nolist
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
" Text-Objects {{{
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
    execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
    execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
    execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
    execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor
" }}}

" vim:fdm=marker
