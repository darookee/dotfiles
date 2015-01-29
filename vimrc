" ~darookee/.vimrc

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
" Plugins {{{
set nocompatible
filetype off

call plug#begin() 
Plug 'bling/vim-airline'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'

Plug 'dyng/ctrlsf.vim'

Plug 'Shougo/neocomplete.vim'

Plug 'scrooloose/syntastic'

Plug 'SirVer/ultisnips'
Plug 'darookee/vim-snippets'

Plug 'jiangmiao/auto-pairs'

Plug 'c9s/lftp-sync.vim'

Plug 'scrooloose/nerdcommenter'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'

Plug 'airblade/vim-gitgutter'

Plug 'IndexedSearch'
Plug 'roman/golden-ratio'

Plug 'tpope/vim-git'
Plug 'pangloss/vim-javascript'
Plug 'leshill/vim-json'
Plug 'StanAngeloff/php.vim'
Plug 'evidens/vim-twig'
Plug 'gorodinskiy/vim-coloresque'

Plug 'sjl/gundo.vim'

let s:vimlocalpluginsrc = expand($HOME . '/.vim/local.plugins')
if filereadable(s:vimlocalpluginsrc)
    exec ':so ' . s:vimlocalpluginsrc
endif

call plug#end() " }}}
filetype plugin indent on
syntax enable

" vim:fdm=marker
