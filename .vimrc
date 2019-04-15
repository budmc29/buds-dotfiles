set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-commentary' " comment sytax aware
Plugin 'kien/ctrlp.vim' "fuzzy searching
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-rails'
Plugin 'airblade/vim-gitgutter' " column diff for git
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mbbill/undotree'
Plugin 'gioele/vim-autoswap' " buffer and swapfile manager
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jebaum/vim-tmuxify'
Plugin 'vimwiki/vimwiki'
Plugin 'sickill/vim-pasta' " content aware paste and indent
Plugin 'ngmy/vim-rubocop'
Plugin 'benmills/vimux'
Plugin 'tpope/vim-endwise' " auto add matching end keywords
Plugin 'townk/vim-autoclose' " Auto close matching bracers
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'leafgarland/typescript-vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-rhubarb'
Plugin 'takac/vim-hardtime'

" Javascript
Plugin 'pangloss/vim-javascript'
Plugin 'MaxMEllon/vim-jsx-pretty'
" Plugin 'leshill/vim-json'
" Plugin 'kchmck/vim-coffee-script'
" Plugin 'w0rp/ale'
Plugin 'ianks/vim-tsx'

" React
Plugin 'mxw/vim-jsx'

" Plugin 'scrooloose/syntastic' " sintax highlighting for hg and git
" Plugin 'tpope/vim-surround'
" Plugin 'vim-scripts/php.vim-html-enhanced'
" Plugin 'scrooloose/nerdtree' " show filetree
" Plugin 'gabebw/vim-spec-runner'
" Plugin 'tpope/vim-obsession' " vim session management
" Plugin 'SirVer/ultisnips'
" Plugin 'honza/vim-snippets'
" Plugin 'vim-scripts/snipMate'
" Plugin 'dyng/ctrlsf.vim' " search inside files using ag
" Plugin 'godlygeek/tabular'
" Plugin 'drmingdrmer/xptemplate' " snippet plugin
" Plugin 'rking/ag.vim'
" Plugin 'easymotion/vim-easymotion'
" Plugin 'xolox/vim-session' " good session manager, using obsession for tmux

" colorschemes
Plugin 'blueshirts/Darcula' " preffered theme for console

call vundle#end()            " required
filetype plugin indent on    " required

" colorscheme base16-tomorrow
set background=dark
colorscheme darcula " default theme for console

" don't show the gui
set guioptions-=m
set guioptions-=T
set guioptions-=r

"old regexp syntax to increase ruby files speed
set re=1

"don't look for autocomplete suggestions everywhere
set complete-=i

set t_ut= "fix tmux transparent background problem
set ttimeoutlen=50 " reduce needed time to enter/exit insert mode
set updatetime=100

set nocompatible
set hidden "auto hide modified buffers when swithcing to another buffer
set expandtab
set tabstop=2
set shiftwidth=2 "set tabwith to 2 spaces, for ruby
set linebreak "don't split word when doing soft break
set smarttab
set history=10000 "history line to remember
set autoread "refresh file when is modified somewhere else
set ignorecase "ignore case when searching
set incsearch " start search as soon as you type
set hlsearch "highlight search results
set cindent "better indenting with vim
set guifont=Source\ Code\ Pro\ 22 " font and line-height
set linespace=6

set number
set relativenumber
set autoindent
set copyindent
set smartcase
set nofoldenable

set backspace=2 " make backspace work like most other programs

syntax on
syntax enable
filetype on
filetype plugin on
filetype indent on

runtime macros/matchit.vim

autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype php setlocal ts=4 sw=4 sts=0 expandtab

let g:ctrlp_cache_dir = $HOME . '/.vim/ctrlp-cache'
" save cache for ctrlp plugin, remember to create the dir on new systems
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" change shortcut to ctrlt for ease
let g:ctrlp_map = ',t'
let g:ctrlp_map = ',t'


" vim persisten undo
set undofile
" set a directory to store the undo history
set undodir=~/.vim/undo
set undolevels=10000

" change swap file directory
set dir=$HOME/.vim/swap/


" xolo vim session settings
let g:session_autosave_periodic = 5
" let g:session_autosave = 'yes'

" allow mouse scroll in console vim
set mouse=a

set ruler

set spell spelllang=en_gb

" highlight whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" show mode in status bar
if version >= 700
hi StatusLine term=reverse ctermfg=7 ctermbg=237 gui=undercurl
au InsertEnter * hi StatusLine term=reverse ctermfg=7 ctermbg=24 gui=undercurl guisp=Magenta
au InsertLeave * hi StatusLine term=reverse ctermfg=7 ctermbg=237
endif

" jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set encoding=utf-8
""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""" plugins setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline settings
set laststatus=2 " always show
set noshowmode " don't show the default mode indicator
let g:airline#extensions#eclim#enables = 0 " disable number of hard limit overflowed characters
let g:airline#extensions#tabline#fnamemod = ':t' " show the file name in the line, not the full path

" snippets
let g:UltiSnipsExpandTrigger="<Ctrl>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

"open tmux from vim
let g:tmuxify_custom_command = 'tmux split-window -p 30'

" use markdown in vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki','syntax': 'markdown', 'ext': '.md'}]

let g:javascript_plugin_jsdoc = 1

" Start autocompletion after 3 chars
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_min_num_identifier_candidate_chars = 3
let g:ycm_enable_diagnostic_highlighting = 0

" Don't show YCM's preview window [ I find it really annoying ]
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0


" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" if executable('ag')
"   let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" endif

let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'

let g:hardtime_default_on = 0


""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""" key remapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
map <leader>w ;w<RETURN>
map <leader>m ;echo 'test'<RETURN>

nnoremap ; :
nnoremap : ;

map <F2> <ESC>;Explore<RETURN>
map <F3> <ESC>;UndotreeToggle <bar> UndotreeFocus<RETURN>
nmap <F4> ;TagbarToggle<CR>
map <silent> <leader>/ ;nohlsearch<CR>
" open file that needed root with root
cmap w!! w !sudo tee % >/dev/null

" reload vimrc
map <leader>sr <ESC>;source $MYVIMRC<RETURN><ESC>;echoerr 'vimrc reloaded'<RETURN>

" window management
map <leader>b <ESC>;e#<RETURN>

" inoremap <C-e> <C-o>A
map <Alt-s> <ESC>;w<RETURN>

" yank to machine register
map <leader>y "+y<ESC>;echoerr 'copy to clipboard'<RETURN>
" paste from machine register
map <leader>p <ESC>"+gp<ESC>;echoerr 'pasted from clipboard'<RETURN>
map <leader>P <ESC>"+gP<ESC>;echoerr 'pasted from clipboard'<RETURN>

map <leader>e <ESC>;CtrlPMRUFiles<RETURN>
" map <leader>re <ESC>;! reek %<RETURN>

nnoremap \cd :lcd %:p:h<CR>:pwd<CR>

" vim wiki maping
map <leader>wn <ESC>;e ~/vimwiki/Notes.md <RETURN>
map <leader>wg <ESC>;e ~/vimwiki/Git.md <RETURN>

map <leader>wsc <ESC>;e ~/vimwiki/Scratchpad.md <RETURN>
map <leader>wnl <ESC>;e ~/vimwiki/Linux\ server.md <RETURN>
map <leader>wns <ESC>;e ~/vimwiki/Shell.md <RETURN>
map <leader>wnv <ESC>;e ~/vimwiki/Vim.md <RETURN>
map <leader>wnt <ESC>;e ~/vimwiki/Tmux.md <RETURN>
map <leader>wnm <ESC>;e ~/vimwiki/Mercurial.md <RETURN>

" Run tests commands
map <Leader>vb ;call RunTestFile()<cr>
map <Leader>c ;call RunTestLine()<cr>
" map <Leader>s ;call RunTestLast()<cr>
map <Leader>z <ESC>;VimuxZoomRunner<CR>

" vim tmuxify commands
le g:tmuxify_run = {
\ 'rb': 'bundle exec rspec spec %',
\}

" TODO fix emmet
" vim emmet
" autocmd FileType html,css  EmmetInstall
" autocmd FileType html,css imap <TAB> <plug>(emmet-expand-abbr)
" let g:user_emmet_install_global = 1
" imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}
" ctrl shift f searcher
" map <leader>f <ESC>;CtrlSF

" this needs to be there for the color column  to work
highlight ColorColumn ctermbg=1 guibg=red
autocmd BufReadPost * call matchadd('ColorColumn', '\%80v', 100)

" rubocop config
let g:vimrubocop_rubocop_cmd = '/home/bud/.rvm/gem-'

" Javascript Standardjs
let g:ale_linters = {
\   'javascript': ['semistandard'],
\}

" remove trailing whitespace on save
fun! <SID>StripTrailingWhitespaces()
let l = line(".")
    let c = col(".")
    %s/\s\+$//e
call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Set connect colourn for git diffs
hi diffRemoved ctermfg=red
hi diffAdded   ctermfg=darkgreen

" Functions
function RunTestFile()
  silent !clear
  execute "!bin/spring rspec " .  bufname("%")
endfunction

function RunTestLine()
  silent !clear
  let data = "!bin/spring rspec " .  bufname("%") . ":" . line(".")
  execute data
endfunction

" TODO: implement run last test
function RunTestLast()
  " execute \"!echo \" . data . \" > tmp/last_test_line_command"
  " silent !clear
  " let data = system('!cat tmp/last_test_line_command')
" execute data
  " echom data
endfunction

autocmd BufNewFile,BufRead *.hamlbars set syntax=haml

" vim tricks
" :mv /long/path/to/{file_name,new_name}.txt
