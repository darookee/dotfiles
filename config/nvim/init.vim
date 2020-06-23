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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'Vimjas/vim-python-pep8-indent'

" textobjects
Plug 'kana/vim-textobj-user'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'machakann/vim-sandwich'

" snippets
Plug 'SirVer/ultisnips'

" files
Plug 'justinmk/vim-dirvish'

" filetype support
Plug 'thiagoalmeidasa/vim-ansible-vault'
Plug 'nelsyeung/twig.vim'

" visuals
Plug 'machakann/vim-highlightedyank'

" colors
Plug 'aonemd/kuroi.vim'
Plug 'davidosomething/vim-colors-meh'

call plug#end()
" }}}
" Colors {{{
set termguicolors
colorscheme meh
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
set guicursor=

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

" highlight last paste
nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

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
cnoremap %% <C-R>=expand('%:h').'/'<CR>

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
let g:ale_set_signs = 0
let g:ale_open_list = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_delay = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 1
let g:ale_php_phpcs_standard = 'Symfony'
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
" cohama/lexima.vim {{{
call lexima#add_rule({
            \ 'char': '%',
            \ 'at': '{\%#',
            \ 'input': '% ',
            \ 'input_after': ' %',
            \ 'filetype': ['html.twig', 'twig', 'html.twig.js.css']
            \ })

call lexima#add_rule({
            \ 'char': '{',
            \ 'at': '{\%#',
            \ 'input': '{ ',
            \ 'input_after': ' }',
            \ 'filetype': ['html.twig', 'twig', 'html.twig.js.css']
            \ })
" }}}
" ggVGc/vim-fuzzysearch {{{
let g:fuzzysearch_match_spaces = 1

nmap ,/ :FuzzySearch<CR>
" }}}
" mbbill/undotree {{{
nnoremap <F5> :UndotreeToggle<CR>
" }}}
" jungegunn/fzf.vim {{{
nnoremap <C-p> :Files<CR>
nnoremap _<C-p> :Buffers<CR>
nnoremap _<C-l> :Lines<CR>
nnoremap _<C-t> :Tags<CR>

" Jump to open buffer when available
let g:fzf_buffers_jump = 1

if executable('fd')
    let $FZF_DEFAULT_COMMAND = 'fd --hidden --follow --exclude ".git" --exclude "node_modules" --type f'
elseif executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files'
elseif executable('sift')
    let $FZF_DEFAULT_COMMAND = 'sift --targets'
elseif executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif

" Add preview windows to file command
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
" }}}
" SirVer/ultisnips {{{
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'local.snippets']
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

    let l:stat .= '%<'
    let l:stat .= AddPart(l:active, 'Status', l:active ? '' : '')

    if l:ftype !=? 'qf'
        let l:stat .= l:active?AddPart(l:active, 'Info', ' %3l/%-2.4L:'.(col('.')/100 >= 1?'%-2v':'%-3v')):''

        let l:stat .= l:readonly?AddPart(l:active, 'Warning', ''):''
        let l:stat .= AddPart(l:active, 'Important', '%f')
        let l:stat .= l:modified?AddPart(l:active, 'Info', ''):''
        let l:stat .= l:active?AddPart(l:active, 'Info', ' '.strftime('%F %H:%M', l:ftime)):''

        if l:active
            " right side
            let l:stat .= '%='

            let l:stat .= &paste?AddPart(l:active, 'CriticalInfo', ''):''  
            let l:stat .= l:lineends !=? 0 ? AddPart(l:active, 'Warning', 'ﭭ'):''

            let l:stat .= AddPart(l:active, 'Info', l:ftype.(l:encoding ==? 'utf-8' ? '' : ' ('.l:encoding.')'))

            if exists(':ALELint')
                let l:ale_counts = ale#statusline#Count(bufnr(''))
                let l:ale_all_errors = l:ale_counts.error + l:ale_counts.style_error
                let l:ale_all_non_errors = l:ale_counts.total - l:ale_all_errors

                let l:stat .= AddPart(l:active, 'Info', l:ale_counts.total == 0 ? '%#StatuslineActiveClear#  %*' : '%#StatuslineActiveWarning# '.l:ale_all_non_errors.'  %* %#StatuslineActiveError# '.l:ale_all_errors.'  %*')
            endif

            " TODO: get correct branch and state
            " let l:stat .= AddPart(l:active, (l:state?'Info':'Error'), '🔱 '.l:branch)
        endif
    else
        let l:stat .= l:active?AddPart(l:active, 'Info', ' %4l /%4L'):''
        let l:stat .= AddPart(l:active, 'Important', l:ftype)
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

    autocmd WinEnter * if &ft != 'qf' | setlocal cursorline number | endif
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
    hi StatuslineActiveClear ctermfg=193 ctermbg=65 guifg=#d7ffaf guibg=#5F875F
    hi StatuslineActiveError ctermfg=168 ctermbg=52 guifg=#d75f87 guibg=#5f0000
    hi StatuslineActiveWarning ctermfg=237 ctermbg=172 guifg=#373b41 guibg=#d78700

    " Ale
    if &background == 'light'
        hi! ALEInfoLine guifg=#808000 guibg=#ffff00
        hi! ALEWarningLine guifg=#808000 guibg=#ffff00
        hi! ALEErrorLine guifg=#ff0000 guibg=#ffcccc
    else
        hi! ALEInfoLine guifg=#ffff00 guibg=#555500
        hi! ALEWarningLine guifg=#ffff00 guibg=#555500
        hi! ALEErrorLine guifg=#ff0000 guibg=#550000
    endif
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
" Autocommands {{{
augroup FiletypeSettings
    au!
    " what does this do?
    "au FileType css,scss,less setlocal iskeyword+=-
    au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell

    au FileType text,markdown setlocal nonumber spell

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

    " exit vim when last window is quickfix
    au BufEnter * nested if &filetype == 'qf' && winbufnr(2) == -1 | q! | endif
    " don't use numbers and list chars in quickfix
    au Filetype qf setlocal nonumber nolist nobuflisted
augroup END

augroup Marks
    au!
    au BufLeave *.css,*.scss,*.less normal! mC
    au BufLeave *.html,*.tpl normal! mH
    au BufLeave *.js normal! mJ
    au BufLeave *.php normal! mP
augroup END
" }}}
" Text-Objects {{{
for g:objchar in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
    execute 'xnoremap i' . g:objchar . ' :<C-u>normal! T' . g:objchar . 'vt' . g:objchar . '<CR>'
    execute 'onoremap i' . g:objchar . ' :normal vi' . g:objchar . '<CR>'
    execute 'xnoremap a' . g:objchar . ' :<C-u>normal! F' . g:objchar . 'vf' . g:objchar . '<CR>'
    execute 'onoremap a' . g:objchar . ' :normal va' . g:objchar . '<CR>'
endfor
" }}}
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" vim:fdm=marker
