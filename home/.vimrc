set nocompatible
syntax on
filetype off 
let &t_Co=256

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdTree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'rking/ag.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'derekwyatt/vim-scala'
"Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'fatih/vim-go'
Plugin 'skwp/greplace.vim'
Plugin 'python-mode/python-mode'

set number
set noswapfile
set nobackup
set nowb
set guifont=Monaco:h14
set tabstop=2
set shiftwidth=2
set softtabstop=2
set scrolloff=4
set expandtab
set spell spelllang=en_us
set encoding=utf-8


autocmd BufEnter * silent! lcd %:p:h

set wildignore+=node_modules,env,vendor,.DS_Store,bower_components

set background=dark

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" NERDTree Mappins
" Open Nerd Tree with <Leader>n
" toggle NERD Tree with CTRL N
nmap <silent> <c-n> :NERDTreeToggle<cr>
let NERDTreeIgnore=['\.pyc$', '.DS_Store', '__pycache__'] "don't show .pyc in the Tree 

" Reveal current file in NERDTree with <Leader>r
map <Leader>r <esc>:NERDTreeFind<cr>

let NERDTreeShowHidden=1

" Ag
let g:ag_working_path_mode="r"

" python-mode
let g:pymode_rope = 0
let g:pymode_folding = 0
let g:pymode_lint_checkers = ['pyflakes', 'pep8']
let g:pymode_lint_ignore = "E501,W"

" CtrlP
nnoremap <silent> t :CtrlP<cr>
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]tmp|node_modules|bower_components|\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

let g:ackprg = 'ag --nogroup --nocolor --column'

" Tmux
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

" map keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

call vundle#end()            " required
filetype plugin indent on    " required

set runtimepath^=~/.vim/bundle/ctrlp.vim
