set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-commentary' " comment sytax aware
Plugin 'scrooloose/syntastic' " sintax highlighting
Plugin 'yegappan/mru' " most recent used files tree
Plugin 'scrooloose/nerdtree' " show filetree
Plugin 'bling/vim-airline' " inproved vim information line
Plugin 'kien/ctrlp.vim' "fuzzy searching
Plugin 'mattn/emmet-vim'
Plugin 'vimwiki/vimwiki'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-endwise' " auto add matching end keywords
Plugin 'nathanaelkane/vim-indent-guides' " show indentation guides with \ig
Plugin 'mhinz/vim-signify' " column diff for source control
Plugin 'tpope/vim-surround'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mbbill/undotree'
Plugin 'vim-scripts/matchit.zip' " improve % functionality
Plugin 'Valloric/YouCompleteMe' " autocomplete (needs python compiled)
Plugin 'gioele/vim-autoswap' " buffer and swapfile manager
Plugin 'sickill/vim-pasta' " content aware paste and indent
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-obsession' " vim session management
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'szw/vim-g' " search google from vim
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'jebaum/vim-tmuxify'
Plugin 'Raimondi/delimitMate' " add matching quotes, brackets etc
"
" Plugin 'plasticboy/vim-markdown'
" Plugin 'dyng/ctrlsf.vim' " search inside files using ag
" Plugin 'godlygeek/tabular'
" Plugin 'drmingdrmer/xptemplate' " snippet plugin
" Plugin 'tpope/vim-bundler'
" Plugin 'xolox/vim-misc' " ?
" Plugin 'vim-scripts/snipMate'
" Plugin 'rking/ag.vim'
" Plugin 'easymotion/vim-easymotion'
" Plugin 'takac/vim-hardtime'
" Plugin 'xolox/vim-session' " good session manager, using obsession for tmux

" colorschemes
Plugin 'blueshirts/Darcula'
" Plugin 'cdmedia/itg_flat_vim'
" Plugin 'kreeger/benlight'
" Plugin 'budmc29/colour-schemes'
" Plugin 'croaker/mustang-vim'
" Plugin 'wesgibbs/vim-irblack'
" Plugin 'chriskempson/base16-vim'
" Plugin 'sjl/badwolf'
" Plugin 'sickill/vim-monokai'
" Plugin 'zeis/vim-kolor'
" Plugin 'morhetz/gruvbox'
" Plugin 'romainl/Apprentice'
" Plugin 'jpo/vim-railscasts-theme'
" Plugin 'gregsexton/Muon'
" Plugin 'carlson-erik/wolfpack'
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

" colorscheme base16-tomorrow
set background=dark
" colorscheme benlight
colorscheme darcula

" don't show the gui
set guioptions-=m
set guioptions-=T
set guioptions-=r

set t_ut= "fix tmux transparent background problem

set hidden "auto hide modified buffers when swithcing to another buffer
set expandtab
set tabstop=2
set shiftwidth=2 "set tabwith to 2 spaces, for ruby
set linebreak "don't split word when doing soft break
set smarttab
set history=1000 "history line to remember
set autoread "refresh file when is modified somewhere else
set ignorecase "ignore case when searching

set incsearch " start search as soon as you type
" highlight search results
set hlsearch
"better indenting with vim
set cindent

" font and line-height
set guifont=Source\ Code\ Pro
set linespace=6

set number
set relativenumber
set autoindent
set copyindent
set smartcase
set foldmethod=syntax
set foldnestmax=2
set nofoldenable
set foldlevel=1

" save cache for ctrlp plugin, remember to create the dir on new systems
let g:ctrlp_cache_dir = $HOME . '/.vim/ctrlp-cache'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif


" vim persisten undo
set undofile
" set a directory to store the undo history
set undodir=~/.vim/undo
set undolevels=10000

" change swap file directory
set dir=$HOME/.vim/swap/

filetype on
filetype plugin on
filetype indent on
syntax on

" Hardtime plugin
" let g:hardtime_default_on = 1

" xolo vim session settings
let g:session_autosave_periodic = 5
" let g:session_autosave = 'yes'

" markdown preview plugin map
let vim_markdown_preview_hotkey='<C-m>'

" snippets
let g:UltiSnipsExpandTrigger="<Ctrl>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

"open tmux from vim
let g:tmuxify_custom_command = 'tmux split-window -p 20'
" let g:tmuxify_map_prefix = '<leader>m'

" use markdown in vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki','syntax': 'markdown', 'ext': '.md'}] 

""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""" key remapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F2> <ESC>;NERDTreeToggle ~/work<RETURN>
map <F3> <ESC>;UndotreeToggle <bar> UndotreeFocus<RETURN>

" for most recent used plugin
map <C-e> <ESC>;MRU <RETURN>

" reload vimrc
map <leader>sr <ESC>;source $MYVIMRC<RETURN><ESC>;echoerr 'vimrc reloaded'<RETURN>

" window management
map <leader>v <C-w>_
map <leader>h <C-w><bar>
map <leader>r <C-w>=
map <leader>b <C-w>_ <C-w><bar>

nnoremap ; :
nnoremap : ;
" inoremap <C-e> <C-o>A
map <Alt-s> <ESC>;w<RETURN>
" map <leader>sb <ESC>;! grep -rnw './work/yoyo_bootstrap' -e "
" map <leader>sm <ESC>;! grep -rnw './work/gasbox-marketplace' -e "
" map <leader>sp <ESC>;! grep -rnw './work/gasbox-player' -e "
" map <leader>sa <ESC>;! grep -rnw './work/yoyo-account' -e "
" map <leader>ss <ESC>;! grep -rnw './work/' -e "
" map <leader>sa <ESC>;! grep -rnw './' -e "
" map "+Gp "+gp
" map ;w <ESC>;w<RETURN>
" map ;q <ESC>;wq<RETURN>

" yank to machine register
map <leader>y "+y<ESC>;echoerr 'copy to clipboard'<RETURN>
" paste from machine register
map <leader>p <ESC>"+gp<ESC>;echoerr 'pasted from clipboard'<RETURN>
map <leader>P <ESC>"+gP<ESC>;echoerr 'pasted from clipboard'<RETURN>


" google search with plugin
map <leader>g <ESC>;Google

" vim wiki maping
map <leader>wn <ESC>;e ~/vimwiki/Notes.md <RETURN>
map <leader>wg <ESC>;e ~/vimwiki/Git.md <RETURN>
map <leader>wsc <ESC>;e ~/vimwiki/Scratchpad.md <RETURN>
map <leader>wnl <ESC>;e ~/vimwiki/Linux.md <RETURN>
map <leader>wns <ESC>;e ~/vimwiki/Shell.md <RETURN>



" ctrl shift f searcher
" map <leader>f <ESC>;CtrlSF

" this needs to be there for the color column  to work
highlight ColorColumn ctermbg=1 guibg=red
call matchadd('ColorColumn', '\%80v', 100)

if has("autocmd")
  autocmd bufwritepost .vimrc source ~/.vimrc
endif
