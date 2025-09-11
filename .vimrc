syntax enable
colorscheme slate

set number
set laststatus=2
set hlsearch
set ruler
set tabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=80
set wrap 
set scrolloff=8
set mouse=a
set noswapfile

let mapleader=" "

"====Lexplore===="
nnoremap <Leader>e :Lexplore<CR>
nnoremap <Leader>E :Lexplore<CR>
let g:netrw_banner=0


"====Search===="
set ignorecase 
set smartcase


" ============ SYSTEM CLIPBOARD INTEGRATION ============
" Enable system clipboard (works on most systems)
if has('clipboard')
    set clipboard=unnamedplus   " Linux/Unix
    if has('mac')
        set clipboard=unnamed   " macOS
    endif
endif

"====Status Line===="
set statusline=%F               " File path
set statusline+=\ %m            " Modified flag
set statusline+=\ %r            " Readonly flag
set statusline+=\ %h            " Help buffer flag
set statusline+=\ %w            " Preview window flag
set statusline+=%=              " Switch to right side
set statusline+=\ %y            " File type
set statusline+=\ [%{&ff}]      " File format
set statusline+=\ %p%%          " Percentage through file
set statusline+=\ %l:%c         " Line:Column
set statusline+=\ [%L]          " Total lines

