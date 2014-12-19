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
Plug 'darookee/vim-settings'

Plug 'bling/vim-airline'

"Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_unix.mak' }
"Plug 'Shougo/unite.vim'
"Plug 'Shougo/vimfiler.vim'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'

Plug 'mileszs/ack.vim'

Plug 'Shougo/neocomplete.vim'

Plug 'scrooloose/syntastic'

Plug 'SirVer/ultisnips'
Plug 'darookee/vim-snippets'

"Plug 'Raimondi/delimitMate'
Plug 'jiangmiao/auto-pairs'

"Plug 'mattn/webapi-vim'
"Plug 'mattn/gist-vim'
"Plug 'mattn/unite-gist'

Plug 'c9s/lftp-sync.vim'

Plug 'scrooloose/nerdcommenter'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'

Plug 'airblade/vim-gitgutter'
Plug 'IndexedSearch'
Plug 'roman/golden-ratio'

Plug 'Lokaltog/vim-easymotion'

Plug 'AndrewRadev/splitjoin.vim'
Plug 'tommcdo/vim-lion'

Plug 'tpope/vim-git'
Plug 'pangloss/vim-javascript'
Plug 'leshill/vim-json'
Plug 'StanAngeloff/php.vim'
Plug 'evidens/vim-twig'
Plug 'acustodioo/vim-tmux'
"Plug 'chrisbra/Colorizer'
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
