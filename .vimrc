call plug#begin("~/.vim/plugged")

"Vim LSP"

" install lua to improve performance (brew install lua)

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

if executable('docker-langserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'docker-langserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
        \ 'whitelist': ['dockerfile'],
        \ })
endif

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx', 'typescriptreact', 'javascript', 'javascript.jsx', 'javascriptreact'],
        \ })
endif

if executable('java') && filereadable(expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.600.v20191014-2022.jar'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'eclipse.jdt.ls',
        \ 'cmd': {server_info->[
        \     'java',
        \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        \     '-Dosgi.bundles.defaultStartLevel=4',
        \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
        \     '-Dlog.level=ALL',
        \     '-noverify',
        \     '-Dfile.encoding=UTF-8',
        \     '-Xmx1G',
        \     '-jar',
        \     expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.600.v20191014-2022.jar'),
        \     '-configuration',
        \     expand('~/lsp/eclipse.jdt.ls/config_mac'),
        \     '-data',
        \     getcwd()
        \ ]},
        \ 'whitelist': ['java'],
        \ })
endif

if executable(expand('~/lsp/kotlin-language-server/server/bin/kotlin-language-server'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'kotlin-language-server',
        \ 'cmd': {server_info->[
        \     &shell,
        \     &shellcmdflag,
        \     expand('~/lsp/kotlin-language-server/server/bin/kotlin-language-server')
        \ ]},
        \ 'whitelist': ['kotlin']
        \ })
endif


if executable('vim-language-server')
  augroup LspVim
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'vim-language-server',
        \ 'cmd': {server_info->['vim-language-server', '--stdio']},
        \ 'whitelist': ['vim'],
        \ 'initialization_options': {
        \   'vimruntime': $VIMRUNTIME,
        \   'runtimepath': &rtp,
        \ }})
  augroup END
endif

if executable('bash-language-server')
  augroup LspBash
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'bash-language-server',
          \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
          \ 'allowlist': ['sh'],
          \ })
  augroup END
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gR <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    set signcolumn=no

    let g:lsp_format_sync_timeout = 1000
    let g:lsp_document_highlight_enabled = 0
    autocmd! BufWritePre *.rs,*.go,*.ts,*tsx call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


"Markdown"
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install'  }

"Latex"
Plug 'lervag/vimtex'

"Haskell"
Plug 'neovimhaskell/haskell-vim'

"Kotline"
Plug 'udalov/kotlin-vim'

"tailwind css"
Plug 'mrdotb/vim-tailwindcss'

"Golang"
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries' }
let g:go_fmt_experimental = 1

"TypeScript"
Plug 'leafgarland/typescript-vim'

"Solidity"
Plug 'tomlion/vim-solidity'

"Vyper"
Plug 'vyperlang/vim-vyper'

"Nerd Tree"
Plug 'scrooloose/nerdtree'
map <C-z> :NERDTreeToggle<CR>

"Auto Read"
Plug 'tmux-plugins/vim-tmux-focus-events'
set autoread 
au FocusGained,BufEnter * :checktime

call plug#end()

"Normal Setting"
syntax on
colorscheme peachpuff
hi StatusLine ctermbg=white ctermfg=236
hi Search cterm=NONE ctermfg=white ctermbg=darkgrey
hi Visual cterm=NONE ctermfg=white ctermbg=darkgrey
hi Folded ctermbg=black

filetype plugin on
filetype indent on
set hlsearch
set nocompatible
set t_Co=256
set fileformat=unix
set wildmenu
set ignorecase
set smartcase
set incsearch
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
