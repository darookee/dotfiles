scriptencoding utf-8
" Plug {{{
if has('vim_starting') " Do stuff on startup {{{
" Download vim-plug if not exists {{{
    if !filereadable(stdpath('config').'/autoload/plug.vim')
        echo "Installing vim-plug\n"
        silent call mkdir(stdpath('config').'/autoload/', 'p')
        silent execute '!curl -fLo '.stdpath('config').'/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        source $MYVIMRC
        execute 'PlugInstall!'
    endif
" }}}
endif
" }}}
" }}}
" Plugins {{{
call plug#begin(stdpath('config').'/plugged')

" development
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'

"
Plug 'cohama/lexima.vim'
Plug 'ggVGc/vim-fuzzysearch'
Plug 'mbbill/undotree'

Plug 'kana/vim-textobj-user'
Plug 'Julian/vim-textobj-variable-segment'

" files
Plug 'justinmk/vim-dirvish'
Plug 'kristijanhusak/vim-dirvish-git'

" filetype support
Plug 'thiagoalmeidasa/vim-ansible-vault'

" visuals
Plug 'machakann/vim-highlightedyank'

" colors
Plug 'aonemd/kuroi.vim'

call plug#end()
" }}}
" Colors {{{
set termguicolors
colorscheme kuroi
" }}}
" Config {{{
set number
set cursorline
set ruler
set scrolloff=5
set showmatch " maybe we don't need this
set list
set listchars=tab:»·,eol:↲,nbsp:␣,extends:…

" undo
set undodir=~/.config/nvim/undo
set undofile
set noswapfile

" whitespace
set expandtab
set tabstop=4
set shiftwidth=4

" search
set ignorecase
set smartcase
set gdefault

" wildmenu
set wildignore+=*.swp,*.bak
set wildignore+=*.pyc
set wildignore+=*/.git/**/*,*/.svn/**/*
set wildignore+=*/min/*,*/vendor/*,*/node_modules/*
set wildignore+=*.tar.*
set wildignorecase
set wildmode=list:longest,full

" spelling
"
" would be nice to set this to
" stdpath('data')
"
" set spellfile=~/.tmp/spell.add
"
set nospell spelllang=de,en

nnoremap <silent> ,s :set spell!<CR>

" behavior
set switchbuf=useopen,vsplit
set diffopt+=algorithm:patience,indent-heuristic
set tags+=./.git/tags
set hidden

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
" }}}
" Keys {{{
set pastetoggle=<F10>

" Windows {{{
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j

augroup windows
    autocmd VimResized * :wincmd =
augroup END
" }}}
" INSERT {{{
inoremap jj <ESC>
" }}}
" NORMAL {{{
nnoremap <space> za

" Remove trailing whitespace
nnoremap ,W :%s/\s\+$//<CR>:let @/=''<CR>:nohl<CR>

" run current line in shell and replace with output
nnoremap Q !!$SHELL<CR>

" Split line, opposite of J
nnoremap <silent> S :call BreakHere()<CR>

fun! BreakHere()
    s/\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\r\3\5
    call histdel('/', -1)
endfun
" }}}
" COMMAND {{{
" expand %% to current bufer path
cnoremap && <C-R>=expand('%:h').'/'<CR>

" sudo write files
cnoremap w!! w !sudo tee > /dev/null %
" }}}
" VISUAL {{{
" Align columns
vnoremap _= :!column -t -o" "<CR>gv=
" }}}
" }}}
" Plugins {{{
" dense-analysis/ale {{{
let g:ale_open_list = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_delay = 1000
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_php_phpcs_standard = 'Symfony'
let g:ale_statusline_format = ['‼%d', '‽%d', '']
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" }}}
" cohama/lexima.vim {{{
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
" ggVGc/vim-fuzzysearch {{{
let g:fuzzysearch_match_spaces = 1

nmap ,/ :FuzzySearch<CR>
" }}}
" airblade/gitgutter {{{
if executable('rg')
    let g:gitgutter_grep_command = 'rg -S'
elseif executable('sift')
    let g:gitgutter_grep_command = 'sift -S'
elseif executable('ag')
    let g:gitgutter_grep_command = 'ag -S'
elseif executable('ack')
    let g:gitgutter_grep_command = 'ack -i'
else
    let g:gitgutter_grep_command = 'grep -i'
endif
" }}}
" }}}
" Statusline {{{
fun! SetStatus()
    for l:nr in range(1, winnr('$'))
        call setwinvar(l:nr, '&statusline', '%!Statusline('.l:nr.')')
    endfor
endfun

fun! Statusline(winnr)

    fun! AddPart(active, higroup, content)
        return '%#Statusline'.(a:active?'Active':'Inactive').a:higroup.'# '.a:content.' %*'
    endfun

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
    let l:ftime = getftime(l:filepath)
    let l:lineends = search('\s\+$', 'nw')

    let l:stat .= AddPart(l:active, 'Status', l:active ? '❗' : '❕')

    let l:stat .= l:active?AddPart(l:active, 'Info', ' %3l/%L:'.(col('.')/100 >= 1?'%v':'%2v')):''

    let l:stat .= '%<'
    let l:stat .= l:readonly?AddPart(l:active, 'Warning', '🔒'):''
    let l:stat .= AddPart(l:active, 'Important', '%f')
    let l:stat .= l:modified?AddPart(l:active, 'Info', '💾'):''
    let l:stat .= l:active?AddPart(l:active, 'Info', '🕛'.strftime('%F %H:%M', l:ftime)):''

    if l:active
        " right side
        let l:stat .= '%='

        let l:stat .= &paste?AddPart(l:active, 'CriticalInfo', '📋'):''
        let l:stat .= l:lineends !=? 0 ? AddPart(l:active, 'Warning', '‼'):''

        let l:stat .= AddPart(l:active, 'Info', l:ftype.':'.l:encoding)
    endif

    return l:stat
endfun

augroup status
    au!
    au VimEnter,WinEnter,BufWinEnter,BufUnload * call SetStatus()
    au Filetype qf call SetStatus()
augroup END
" }}}
" Highlights {{{
augroup highlights
    au!

    autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

    autocmd WinEnter * setlocal cursorline number
    autocmd WinLeave * setlocal nocursorline nonumber

    autocmd ColorScheme * call s:AddCustomHighlights()
    autocmd VimEnter * call s:AddCustomHighlights()

augroup END

fun! s:AddCustomHighlights()
    " remove background color to display the terminals' theme background color
    "hi Normal ctermbg=NONE guibg=NONE

    hi link ExtraWhitespace Error
    " hi ExtraWhitespace cterm=underline ctermfg=168 ctermbg=52 gui=underline guifg=#d75f87 guibg=#5f0000

    hi link SpellBad Error
    hi SpellCap cterm=underline
    hi SpellLocal cterm=underline
    hi SpellRare cterm=underline

    hi OverLength ctermbg=3 ctermfg=white guibg=#FF5555 guifg=#424450
    call matchadd('OverLength', '\%81v', 100)

    hi HighlightedyankRegion cterm=reverse gui=reverse

    hi StatuslineActiveImportant ctermfg=7 ctermbg=0 guibg=#556270 guifg=#C7F464
    hi StatuslineInactiveImportant ctermfg=6 ctermbg=1
    hi link StatuslineActiveStatus StatuslineActiveImportant
    hi link StatuslineInactiveStatus StatusLineInactiveImportant
endfun

" }}}
" Functions {{{
" mkdir on save when dir does not exist {{{
fun! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let l:dir=fnamemodify(a:file, ':h')
        if !isdirectory(l:dir)
            call mkdir(l:dir, 'p')
        endif
    endif
endfun

augroup CreateDirOnWrite
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
" }}}
" Rename {{{
fun! s:Rename(name, bang)
    let l:curfile = expand('%:p')
    let l:curfilepath = expand('%:p:h')
    let l:newname = l:curfilepath.'/'.a:name
    let v:errmsg = ''
    silent! exe 'saveas'.a:bang.' '.l:newname
    if v:errmsg =~# '^$\|^E329'
        if expand('%:p') !=# l:curfile && filewritable(l:curfile)
            silent exec 'bwipe! '.l:curfile
            if delete(l:curfile)
                echoerr 'Could not delete '.l:curfile
            endif
        endif
    else
        echoerr v:errmsg
    endif
endfun

command! -nargs=* -complete=file -bang Rename :call s:Rename("<args>", "<bang>")
" }}}
" filter quickfix list {{{
fun! s:FilterQuickfixList(bang, pattern)
    let l:cmp = a:bang ? '!~#' : '=~#'
    call setqflist(filter(getqflist(), "bufname(v:val['bufnr') ".l:cmp.' a:pattern'))
endfun

command! -bang -nargs=1 -complete=file QFilter call s:FilterQuickfixList(<bang>0, <q-args>)
" }}}
" }}}
" Commands {{{
command! Remove :call delete(@%)
" }}}

" vim:fdm=marker
