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
" Plugin 'takac/vim-hardtime'
Plugin 'easymotion/vim-easymotion'
Plugin 'gioele/vim-autoswap'
Plugin 'sickill/vim-pasta'
" Plugin 'vim-scripts/CSApprox'

" colorschemes
Plugin 'sickill/vim-monokai'
Plugin 'zeis/vim-kolor'
Plugin 'morhetz/gruvbox'
Plugin 'romainl/Apprentice'
Plugin 'jpo/vim-railscasts-theme'
Plugin 'gregsexton/Muon'
Plugin 'carlson-erik/wolfpack'
Plugin 'cdmedia/itg_flat_vim'
Plugin 'kreeger/benlight'
Plugin 'budmc29/colour-schemes'
" Plugin 'andrwb/vim-lapis256'
" Plugin 'wellsjo/wellsokai.vim'
" Plugin 'atelierbram/vim-colors_atelier-schemes'
" Plugin 'glortho/feral-vim'
" Plugin 'queyenth/oxeded.vim'
" Plugin 'fabi1cazenave/kalahari.vim'
" Plugin 'Wutzara/vim-materialtheme'
" Plugin 'jlesquembre/peaksea'
" Plugin 'scheakur/vim-scheakur'
" Plugin 'orthecreedence/void.vim'
" Plugin 'jlund3/colorschemer'
" Plugin 'blackgate/tropikos-vim-theme'
" Plugin 'MPiccinato/wombat256'
" Plugin 'thomd/vim-wasabi-colorscheme'
" Plugin 'zsoltf/vim-maui'
" Plugin 'xero/sourcerer.vim'
" Plugin 'gilgigilgil/anderson.vim'
" Plugin 'DrSpatula/vim-buddy'
" Plugin 'vim-scripts/moria'
" Plugin 'Donearm/Ubaryd'
" Plugin 'mkarmona/colorsbox'

call vundle#end()            " required
filetype plugin indent on    " required

" let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
" colorscheme badwolf
" colorscheme base16-tomorrow
set background=dark
colorscheme benlight
" good for rails, bad for html
" colorscheme badwolf


" don't show the gui
set guioptions-=m
set guioptions-=T
set guioptions-=r

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

set incsearch " start search as soon as you type
" highlight search results
set hlsearch
"better indenting with vim
set cindent
" set a horizontal 80w hard limit
" set colorcolumn=80
" highlight ColorColumn ctermbg=7 guibg=tomato
highlight ColorColumn ctermbg=0 guibg=#FF6364
call matchadd('ColorColumn', '\%81v', 100)
" font and line-height
set guifont=Source\ Code\ Pro
set linespace=6
" vim persisten undo
set undofile
" set a directory to store the undo history
set undodir=~/.vimundo
set undolevels=1000

" change swap file directory
set dir=$HOME/.vim/swap//

filetype on
filetype plugin on
filetype indent on
syntax on

" Hardtime plugin
let g:hardtime_default_on = 1
" xolo vim session settings
let g:session_autosave_periodic = 5
" let g:session_autosave = 'yes'

"neocomplete settings
" Use neocomplete.
" let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
" let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" " keys remapping

" activate tab-airline 
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t'

map <F2> <ESC>;NERDTree ~/work<RETURN>
map <F3> <ESC>;UndotreeToggle<RETURN>
" for most recent used plugin
map <C-t> <ESC>;MRU <RETURN>

" window management
map <leader>v <C-w>_
map <leader>h <C-w><bar>
map <leader>r <C-w>=
map <leader>b <C-w>_ <C-w><bar>

nnoremap ; :
nnoremap : ;
" inoremap <C-e> <C-o>A
map <Alt-s> <ESC>;w<RETURN> 
map <leader>sb <ESC>;! grep -rnw './work/yoyo_bootstrap' -e "
map <leader>sm <ESC>;! grep -rnw './work/gasbox-marketplace' -e "
map <leader>sp <ESC>;! grep -rnw './work/gasbox-player' -e "
map <leader>sa <ESC>;! grep -rnw './work/yoyo-account' -e "
map <leader>ss <ESC>;! grep -rnw './work/' -e "
map "+Gp "+gp
" map ;w <ESC>;w<RETURN>
" map ;q <ESC>;wq<RETURN>
