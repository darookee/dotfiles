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
filetype off
" Plugins {{{
call plug#begin()
" File finder
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nixprime/cpsm', { 'do': 'env PY3=OFF ./install.sh' }
Plug 'jeetsukumaran/vim-filebeagle'
Plug 'romainl/vim-qf'

" Colors
Plug 'andreypopp/vim-colors-plain'
Plug 'abnt713/vim-hashpunk'
Plug 'smallwat3r/vim-mono_sw'
Plug 'TroyFletcher/vim-colors-synthwave'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Filetype
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv'
Plug 'tobyS/php-accessors.vim'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'

" textobj
Plug 'kana/vim-textobj-user'
" iu
" ic
" ih
" ix
" if
" ida
" iv
Plug 'Julian/vim-textobj-variable-segment'

" snippets
if has("python3")
    Plug 'SirVer/ultisnips'
endif

" Text
Plug 'tpope/vim-surround'
Plug 'FooSoft/vim-argwrap'
Plug 'cohama/lexima.vim'
Plug 'machakann/vim-highlightedyank'

" navigation
" f and F further
" _/ search
Plug 'ggVGc/vim-fuzzysearch'
" visual undo
Plug 'mbbill/undotree'
" statusbar bling
" search result highlighting
Plug 'timakro/vim-searchant'
" buffer content preview
Plug 'junegunn/vim-peekaboo'
" modern replacement for matchit
Plug 'andymass/vim-matchup'
" numbers only visible in active windows
Plug 'AssailantLF/vim-active-numbers'
call plug#end()
" }}}
" Colors {{{
" 'fix' for tmux and termguicolors
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
    set t_ut=
endif
set background=dark
colorscheme mono_sw
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

set formatoptions=tcql1jn

set list
set listchars=tab:»·,eol:↲,nbsp:␣,extends:…
if has('linebreak')
  set breakindent
  let &showbreak = '↳ '
  set cpoptions+=n
end
set cpo+=$
" Thanks /u/Bloodshot25
" https://www.reddit.com/r/vim/comments/3r8p6x/do_any_of_you_vim_users_use_a_4k_display/cwmen38
set fillchars=vert:│,fold:┈

set updatetime=1000
set encoding=utf-8
scriptencoding utf-8

set diffopt-=internal
set diffopt+=algorithm:patience,indent-heuristic

set tags+=./.git/tags

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
nnoremap ,W :%s/\s\+$//<CR>:let @/=''<CR>:nohl<CR>

" Break line, opposite of J
nnoremap <silent> S :call BreakHere()<CR>

" replace with <leader>r/R
" (https://www.reddit.com/r/vim/comments/2l6adg/how_do_you_do_a_search_replace_to_minimize_the/clrvf69)
nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
nnoremap <leader>R :%s/\<<C-r><C-a>\>//g<Left><Left>

" run current line in shell and replace line with output
" https://www.youtube.com/watch?v=MquaityA1SM
noremap Q !!$SHELL<CR>

" replace words with .
" (https://www.reddit.com/r/vim/comments/4gjbqn/what_tricks_do_you_use_instead_of_popular_plugins/d2i2ogx)
nnoremap c* *Ncgn

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
if executable('fd')
    let g:ctrlp_user_command = 'fd --type f --color=never "" %s'
    let g:ctrlp_use_caching = 0
    let g:ctrlp_match_window_reversed = 0
elseif executable('rg')
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
elseif executable('ag')
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
    let g:ctrlp_use_caching = 1
endif

let g:ctrlp_match_func = { 'match': 'cpsm#CtrlPMatch' }
" CtrlP_StatusLine: {{{
" Arguments: focus, byfname, s:regexp, prv, item, nxt, marked
"            a:1    a:2      a:3       a:4  a:5   a:6  a:7
fu! CtrlP_main_status(...)
  let l:regex = a:3 ? 'regex %*' : ''
  let l:prv = '%#StatuslineDim# '.a:4.' %*'
  let l:item = '%#StatuslineHighlighted# '.a:5.' %*'
  let l:nxt = '%#StatuslineDim# '.a:6.' %*'
  let l:byfname = ' '.a:2.' %*'
  let l:dir = ' '.fnamemodify(getcwd(), ':~').' %*'
  retu  l:prv . l:item . l:nxt . '%=%*%<' . l:byfname . l:regex . l:dir
endf

" Argument: len
"           a:1
fu! CtrlP_progress_status(...)
  let l:len = '%#StatuslineHighlighted# '.a:1.' %*'
  let l:dir = ' %=%<%#StatuslineDim# '.getcwd().' %*'
  retu l:len.l:dir
endf

let g:ctrlp_status_func = {
  \ 'main': 'CtrlP_main_status',
  \ 'prog': 'CtrlP_progress_status'
  \}
" }}}
nnoremap <silent> _b :<C-u>CtrlPBuffer<CR>
nnoremap <silent> _t :<C-u>CtrlPTag<CR>
" }}}
" ArgWrap {{{
nnoremap <silent> _a :ArgWrap<CR>
let g:argwrap_tail_comma_braces = '['
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
augroup Emmet
augroup END

" }}}
" MUcomplete {{{
let g:mucomplete#enable_auto_at_startup = 1
" }}}
" ale {{{
let g:ale_open_list = 0
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 1000
let g:ale_lint_on_enter = 0
let g:ale_php_phpcs_standard = 'Symfony'
let g:ale_statusline_format = ['‼%d', '‽%d', '']
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" }}}
" Gitgutter {{{
let g:gitgutter_sign_added = '●'
let g:gitgutter_sign_modified = '●'
let g:gitgutter_sign_removed = '●'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = 'w'
let g:gitgutter_grep_command = 'rg -i'
let g:gitgutter_highlight_lines = 0
" }}}
" }}}
" Grep {{{
command! -nargs=+ -complete=file_in_path -bar Grep silent! grep! <args> | cwindow 3 | redraw!
if executable('rg')
    set grepprg=rg\ -S\ -i\ --vimgrep
    set grepformat=%f:%l:%c:%m
elseif executable('sift')
    set grepprg=sift\ -nMs\ --no-color\ --binary-skip\ --column\ --no-group\ --git\ --follow
    set grepformat=%f:%l:%c:%m
elseif executable('ag')
    set grepprg=ag\ --vimgrep\ --ignore=\"**.min.js\"
    set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ack')
    set grepprg=ack\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
else
    set grepprg=grep\ -R
    set grepformat=%f:%m
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
" Formatting {{{
augroup Formatting
    au!
    if executable('prettier')
        autocmd FileType javascript setlocal formatprg=prettier\ --stdin\ --single-quote\ --trailing-comma\ es5\ --tab-width\ 4
    endif
    if executable('jq')
        autocmd FileType json setlocal formatprg=jq\ .
    endif
    if executable('sqlformat')
        autocmd FileType sql setlocal formatprg=sqlformat\ --reindent\ -
    endif
    if executable('remark')
        autocmd FileType markdown setlocal formatprg=remark\ --no-color\ --silent
    endif
augroup END
" }}}
" Status {{{
" http://www.blaenkdenum.com/posts/a-simpler-vim-statusline/
function! Status(winnr)
    let l:stat = ''
    let l:active = winnr() == a:winnr
    let l:buffer = winbufnr(a:winnr)

    let l:modified = getbufvar(l:buffer, '&modified')
    let l:readonly = getbufvar(l:buffer, '&ro')
    let l:ftype = getbufvar(l:buffer, '&ft')
    let l:encoding = getbufvar(l:buffer, '&enc')
    let l:type = getbufvar(l:buffer, '&buftype')
    let l:fname = bufname(l:buffer)
    let l:filepath = fnamemodify(l:fname, ':p')
    let l:lineends = search('\s\+$', 'nw')

    function! LinterStatus() abort
        let l:counts = ale#statusline#Count(bufnr(''))

        let l:all_errors = l:counts.error + l:counts.style_error
        let l:all_non_errors = l:counts.total - l:all_errors

        return l:counts.total == 0 ? 'OK' : printf(
                    \   '%dW %dE',
                    \   l:all_non_errors,
                    \   l:all_errors
                    \)
    endfunction

    function! Part(active, num, content)
        if a:active
            return '%#'.a:num.'# ' . a:content . ' %*'
        else
            return ' '.a:content.' '
        endif
    endfunction

    let l:stat .= Part(l:active, 'StatuslineHighlighted', l:active ? '»' : '«')

    if l:type !=? ''
        let l:stat .= '%<'
        let l:stat .= Part(l:active, 'StatuslineHighlighted', l:type)
        return l:stat
    endif

    " linenumbers only for l:active windows
    if l:active
        " column
        let l:stat .= Part(l:active, 'StatuslineDim', ' %3l/%L:' . (col('.') / 100 >= 1 ? '%v ' : ' %2v '))
        " let l:stat .= '%{VisualPercent()} '
    endif

    " file
    let l:stat .= '%<'

    " read only
    let l:stat .= l:readonly ? Part(l:active, 'StatuslineError', '') : ''

    let l:stat .= Part(l:active, 'StatuslineHighlighted', '%f') .
                \ (l:active ? Part(l:active, 'StatuslineDim', '↺ '.strftime('%F %H:%M', getftime(l:filepath))) : '')

    " file modified
    let l:stat .= (l:modified ? Part(l:active, 'StatusLineWarning', '⇄') : '')

    if l:active
        " paste
        let l:stat .= &paste ? Part(l:active, 'StatuslineHighlighted', '⇣') : ''
    endif

    " right side
    let l:stat .= '%='

    if l:active
        let l:stat .= Part(l:active, 'StatuslineDim', '['.l:ftype.(l:encoding !=? 'utf-8'?':'.l:encoding.'':'').']')

        let l:linter = LinterStatus()
        let l:stat .= Part(l:active, l:linter ==? 'OK' ? 'StatuslineOK' : 'StatuslineError', l:linter)

        " lines ending in whitespace
        let l:stat .= l:lineends !=? 0 ? Part(l:active, 'StatuslineAlert', '↲') : ''

        " git branch
        if exists('*fugitive#head')
            let l:head = fugitive#head(6)

            if empty(l:head) && exists('*fugitive#detect') && !exists('b:git_dir')
                call fugitive#detect(getcwd())
                let l:head = fugitive#head(6)
            endif

            if !empty(l:head)
                if exists('*gitgutter#hunk#hunks')
                    let l:hunks = gitgutter#hunk#hunks(l:buffer)
                    if empty(l:hunks)
                        let l:git_color = 'StatuslinePositive'
                    else
                        let l:git_color = 'StatuslineAlert'
                    endif
                else
                    let l:git_color = 'StatuslineDim'
                endif
                let l:stat .= Part(l:active, l:git_color, ''.(l:head !=? 'master'?' '.l:head.'':''))
            endif
        endif
    endif

    return l:stat
endfunction

function! SetStatus()
  for l:nr in range(1, winnr('$'))
    call setwinvar(l:nr, '&statusline', '%!Status('.l:nr.')')
  endfor
endfunction

augroup status
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter,BufUnload * call SetStatus()
  autocmd Filetype qf call SetStatus()
augroup END
" }}}
" Custom Highlight {{{
augroup highlights
    au!
    autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
    autocmd Syntax * syn match Error '–'
    autocmd Syntax * syn match UnfoldedFoldLine "^.*{{{"

    " Cursor line only on active window
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline

    " custom highlights
    autocmd ColorScheme * call AddCustomHighlights()
    autocmd VimEnter * call AddCustomHighlights()
augroup END

function! AddCustomHighlights()
    hi StatusLine ctermfg=0 ctermbg=8 cterm=none guibg=#1B1E21
    hi StatusLineNC ctermfg=0 ctermbg=8 cterm=none guibg=#204050

    hi StatuslineDim ctermfg=8 ctermbg=0 guibg=#10161A
    hi StatuslineHighlighted ctermfg=7 ctermbg=0 guibg=#556270 guifg=#C7F464

    hi StatuslinePositive ctermfg=8 ctermbg=2 guibg=#d4edda guifg=#155724
    hi StatuslineWarning ctermfg=8 ctermbg=3 guibg=#fff3cd guifg=#856404
    hi StatuslineAlert ctermfg=7 ctermbg=1 guibg=#f8d7da guifg=#721c24



    hi ExtraWhitespace ctermfg=1 ctermbg=1 guibg=#ff0000 guifg=#ff0000
    hi SpellBad cterm=underline
    hi SpellCap cterm=underline
    hi SpellLocal cterm=underline
    hi SpellRare cterm=underline



    hi GitGutterAdd ctermbg=2 guifg=#155724
    hi GitGutterChange ctermbg=3 guifg=#856404
    hi GitGutterDelete ctermbg=1 guifg=#721C24
    hi GitGutterChangeDelete ctermbg=8 guifg=#151A1E


    hi HighlightedyankRegion cterm=reverse gui=reverse

    hi OverLength ctermbg=3 ctermfg=white guibg=#FF5555 guifg=#424450
    call matchadd('OverLength', '\%81v', 100)

    hi UnfoldedFoldLine ctermfg=white guifg=#E0E0E0

    if g:colors_name ==? 'dracula'
        hi Visual cterm=reverse
        hi phpStructure ctermfg=4
    endif

    if &termguicolors ==? '1'
        hi Search guibg=#103040 guifg=#ee8866 cterm=NONE
    endif
endfunction
" }}}
" Functions{{{
" Mkdir on write if it does not exist {{{
function! MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let l:dir=fnamemodify(a:file, ':h')
        if !isdirectory(l:dir)
            call mkdir(l:dir, 'p')
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
    call histdel('/', -1)
endfunction

" http://www.vim.org/scripts/script.php?script_id=2724
function! Rename(name, bang)
    let l:curfile = expand('%:p')
    let l:curfilepath = expand('%:p:h')
    let l:newname = l:curfilepath . '/' . a:name
    let v:errmsg = ''
    silent! exe 'saveas' . a:bang . ' ' . l:newname
    if v:errmsg =~# '^$\|^E329'
        if expand('%:p') !=# l:curfile && filewritable(expand('%:p'))
            silent exe 'bwipe! ' . l:curfile
            if delete(l:curfile)
                echoerr 'Could not delete ' . l:curfile
            endif
        endif
    else
        echoerr v:errmsg
    endif
endfunction

" http://snippetrepo.com/snippets/filter-quickfix-list-in-vim
function! s:FilterQuickfixList(bang, pattern)
  let l:cmp = a:bang ? '!~#' : '=~#'
  call setqflist(filter(getqflist(), "bufname(v:val['bufnr']) ".l:cmp.' a:pattern'))
endfunction
" }}}
" Filetypes {{{
" indenthtml
let g:html_indent_script1 = 'inc'
let g:html_indent_style1 = 'inc'

augroup FiletypeSettings
    au!
    autocmd BufNewFile,BufReadPost *.md set ft=markdown
    " http://vimrcfu.com/snippet/168
    autocmd FileType css,scss,less setlocal iskeyword+=-
    autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
    autocmd FileType text,markdown setlocal nonumber spell
augroup END

augroup QuickFix
    au!
    autocmd Filetype qf nnoremap <buffer> j j
    autocmd Filetype qf nnoremap <buffer> k k

    autocmd Filetype qf setlocal nonumber nolist
augroup END

augroup Marks
    autocmd!
    autocmd BufLeave *.css,*.scss,*.less    normal! mC
    autocmd BufLeave *.html                 normal! mH
    autocmd BufLeave *.js                   normal! mJ
    autocmd BufLeave *.php                  normal! mP
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
for g:objchar in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
    execute 'xnoremap i' . g:objchar . ' :<C-u>normal! T' . g:objchar . 'vt' . g:objchar . '<CR>'
    execute 'onoremap i' . g:objchar . ' :normal vi' . g:objchar . '<CR>'
    execute 'xnoremap a' . g:objchar . ' :<C-u>normal! F' . g:objchar . 'vf' . g:objchar . '<CR>'
    execute 'onoremap a' . g:objchar . ' :normal va' . g:objchar . '<CR>'
endfor
" }}}

" vim:fdm=marker
