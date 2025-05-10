syntax on
colorscheme peachpuff
hi StatusLine ctermbg=white ctermfg=236
hi Search cterm=NONE ctermfg=white ctermbg=darkgrey
hi Visual cterm=NONE ctermfg=white ctermbg=darkgrey
hi Folded ctermbg=black
hi Comment ctermfg=green

filetype plugin on
filetype indent on

set hlsearch
set incsearch

set nocompatible
set t_Co=256
set fileformat=unix

set wildmenu
set ignorecase
set smartcase
set smartindent

set tabstop=4 
set shiftwidth=4

set expandtab
set autowrite
set ruler
set laststatus=2
set wildmenu
set path+=**
set re=0

imap <c-c> <esc>

if &term =~ "^screen"
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

call plug#begin("~/.vim/plugged")

"LSC
Plug 'natebosch/vim-lsc'

let g:lsc_enable_autocomplete = v:true
let g:lsc_auto_map = v:true
let g:lsc_reference_highlights = v:false
let g:lsc_server_commands = {
    \ 'javascript': 'typescript-language-server --stdio',
    \ 'typescript': 'typescript-language-server --stdio',
    \ }
" \ 'python' : 'pyls',


"Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install'  }

"Latex
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

"Haskell
Plug 'neovimhaskell/haskell-vim'

"Kotlin
Plug 'udalov/kotlin-vim'

"tailwind css
Plug 'mrdotb/vim-tailwindcss'

"TypeScript
Plug 'leafgarland/typescript-vim'

"Solidity
Plug 'tomlion/vim-solidity'

"Nerd Tree
Plug 'scrooloose/nerdtree'
map <C-z> :NERDTreeToggle<CR>

"Auto Read
Plug 'tmux-plugins/vim-tmux-focus-events'
set autoread 
au FocusGained,BufEnter * :checktime

"Prettier
Plug 'prettier/vim-prettier'


call plug#end()

