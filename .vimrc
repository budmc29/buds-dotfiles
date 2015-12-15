set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'sjl/badwolf'
Plugin 'blueshirts/Darcula'
Plugin 'tpope/vim-commentary'
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
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-endwise'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'mhinz/vim-signify'
Plugin 'wakatime/vim-wakatime'
Plugin 'tpope/vim-surround'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'wesgibbs/vim-irblack'
Plugin 'dyng/ctrlsf.vim'
Plugin 'mbbill/undotree'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'vim-scripts/matchit.zip'
Plugin 'Valloric/YouCompleteMe'
Plugin 'drmingdrmer/xptemplate'
" Plugin 'zhaocai/GoldenView.Vim'

call vundle#end()            " required
filetype plugin indent on    " required

" good for html
colorscheme base16-twilight
" colorscheme base16-tomorrow

" good for rails, bad for html
" colorscheme badwolf

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
set ignorecase
set smartcase
set foldmethod=syntax
set foldnestmax=2
set nofoldenable
set foldlevel=1
" start search as soon as you type
set incsearch
" highlight search results
set hlsearch
"better indenting with vim
set cindent
" set a horizontal 80w hard limit
set colorcolumn=80
" font and line-height
set guifont=Source\ Code\ Pro
set linespace=6
" remove compatibility with vi 
set nocompatible

filetype on
filetype plugin on
filetype indent on
syntax on
highlight ColorColumn ctermbg=0 guibg=#282828

" xolo vim session settings
let g:session_autosave_periodic = 5
let g:session_autosave yes

" keys remapping
map <F2> <ESC>:NERDTree ~/work<RETURN>
map <F3> <ESC>:UndotreeToggle<RETURN>
" for most recent used plugin
map <C-e> <ESC>:MRU <RETURN>

" window management
map <leader>v <C-w>_
map <leader>h <C-w><bar>
map <leader>r <C-w>=
map <leader>b <C-w>_ <C-w><bar>
map ;w <ESC>:w<RETURN> 
map ;W <ESC>:w<RETURN> 
map <Alt-s> <ESC>:w<RETURN> 

" inoremap <C-e> <C-o>A
