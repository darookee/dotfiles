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
set encoding=utf-8
scriptencoding utf-8
" Plugins {{{
call plug#begin()

" colors
Plug 'dracula/vim'

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
colorscheme dracula
" }}}
" Settings {{{
filetype plugin indent on
syntax on
" }}}

" vim:fdm=marker
