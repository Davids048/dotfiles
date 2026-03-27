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

set ignorecase
set smartcase

" System clipboard integration
if has('clipboard')
    set clipboard=unnamedplus
    if has('mac')
        set clipboard=unnamed
    endif
endif
