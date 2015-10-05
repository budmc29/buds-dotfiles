set nocompatible
filetype plugin on
syntax on
" execute pathogen#infect()

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'sjl/badwolf'
Plugin 'bulenkov/Darcula'
Plugin 'bulenkov/Darcula'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'Raimondi/delimitMate'
Plugin 'yegappan/mru'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'croaker/mustang-vim'
Plugin 'vim-scripts/snipMate'
Plugin 'vimwiki/vimwiki'

call vundle#end()            " required
filetype plugin indent on    " required

colorscheme base16-tomorrow
set background=dark
" don't show the gui
set guioptions = ae
set number
set relativenumber
set autoindent
set copyindent
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
filetype on
filetype plugin on
filetype indent on

set ignorecase
set smartcase

set foldmethod=syntax
set foldnestmax=2
set nofoldenable
set foldlevel=1

map <F2> <ESC>:NERDTree ~/work<RETURN>
" for most recent used plugin
map <C-e> <ESC>:MRU <RETURN>
syntax on
" set a horizontal 80w hard limit
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=darkgrey
" font and line-height
set guifont=Source\ Code\ Pro
set linespace=6
" for nerdtree comment
filetype plugin on
" remove compatibility with vi 
