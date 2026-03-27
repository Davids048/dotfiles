call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
call plug#end()

" fzf keymaps
nnoremap <leader>ff :Files<CR>
nnoremap <leader>tg :Rg<CR>
nnoremap <leader>b :Buffers<CR>

" osc52 yank
nmap y <Plug>OSCYankOperator
nmap yy y_
vmap y <Plug>OSCYankVisual
