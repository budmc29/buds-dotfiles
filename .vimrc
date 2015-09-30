execute pathogen#infect()

colorscheme base16-tomorrow
set background=dark
" don't show the gui
set guioptions = ae
set number
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
set nocompatible
